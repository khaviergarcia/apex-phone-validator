import xml.etree.ElementTree as ET
import csv
import re
import requests

# URL del XML crudo de Google
XML_URL = "https://raw.githubusercontent.com/google/libphonenumber/master/resources/PhoneNumberMetadata.xml"
OUTPUT_FILE = "PhoneMetadata_Import.csv"

# FILTRO: Deja esto vacío [] si quieres TODOS los países (Cuidado con los límites de SF)
# Si solo operas en ciertos mercados, pon sus códigos ISO.
TARGET_COUNTRIES = ['ES', 'US', 'MX', 'FR', 'GB', 'CO'] 

def get_pattern(element, tag_name):
    """Extrae el patrón de validación nacional eliminando espacios/saltos de línea"""
    found = element.find(tag_name)
    if found is not None:
        national = found.find('nationalNumberPattern')
        if national is not None and national.text:
            # Apex regex no se lleva bien con espacios en blanco dentro del patrón a menos que se escape
            return national.text.replace('\n', '').replace(' ', '')
    return None

def parse_metadata():
    print("Descargando XML...")
    response = requests.get(XML_URL)
    root = ET.fromstring(response.content)
    
    territories = root.find('territories')
    
    rows = []
    
    print("Procesando territorios...")
    for territory in territories.findall('territory'):
        iso_code = territory.get('id')
        country_code = territory.get('countryCode')
        
        # Omitir si es '001' (Mundo) o si no está en nuestra lista de objetivos
        if iso_code == '001' or (TARGET_COUNTRIES and iso_code not in TARGET_COUNTRIES):
            continue

        # Extraer Regexes
        general_regex = get_pattern(territory, 'generalDesc')
        mobile_regex = get_pattern(territory, 'mobile')
        fixed_regex = get_pattern(territory, 'fixedLine')
        
        # Si no hay mobile/fixed específico, a veces Google usa el general.
        # Ajusta esta lógica según cuan estricta quieras la validación.
        if not mobile_regex: mobile_regex = general_regex
        if not fixed_regex: fixed_regex = general_regex

        # Preparar fila para CMDT
        # DeveloperName debe ser seguro (solo letras, numeros, guiones bajos)
        dev_name = f"Region_{iso_code}"
        
        row = {
            'DeveloperName': dev_name,
            'Label': f"{iso_code} (+{country_code})",
            'IsoCode__c': iso_code,
            'CountryCode__c': country_code,
            'GeneralDescRegex__c': general_regex,
            'MobileRegex__c': mobile_regex,
            'FixedLineRegex__c': fixed_regex
        }
        rows.append(row)

    # Escribir CSV
    headers = ['DeveloperName', 'Label', 'IsoCode__c', 'CountryCode__c', 'GeneralDescRegex__c', 'MobileRegex__c', 'FixedLineRegex__c']
    
    with open(OUTPUT_FILE, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=headers)
        writer.writeheader()
        writer.writerows(rows)
        
    print(f"Generado {OUTPUT_FILE} con {len(rows)} registros.")

if __name__ == "__main__":
    parse_metadata()
# Phone Validator - Salesforce Apex

Este proyecto es una solución de validación de números de teléfono para Salesforce que utiliza expresiones regulares basadas en los metadatos de países de libphonenumber (Google).

## Funcionalidad

El proyecto proporciona validación de números de teléfono para más de 200 países/regiones utilizando patrones regex específicos para cada país:

- **Validación de móviles**: Verifica si el número es un teléfono móvil válido
- **Validación de fijos**: Verifica si el número es un teléfono fijo válido
- **Validación general**: Verifica si el número tiene un formato válido para el país
- **Limpieza automática**: Elimina caracteres no numéricos (+, -, espacios, paréntesis)
- **Manejo de prefijos**: Detecta y procesa automáticamente códigos de país

## Archivos del Proyecto

```
phone-validator/
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/
│           │   ├── PhoneValidator.cls          # Clase principal de validación
│           │   └── PhoneValidator_Test.cls     # Tests unitarios
│           └── customMetadata/
│               └── PhoneNumberMetadata.*.md   # Metadatos por país
├── PhoneMetadata_Upload.csv                    # Datos de países (regex)
└── README.md
```

## Uso

### Validar un número de teléfono

```apex
// Con código de país
Boolean isValid = PhoneValidator.isValidNumber('+34612345678', 'ES');
System.debug(isValid); // true

// Sin código de país
Boolean isValid = PhoneValidator.isValidNumber('612345678', 'ES');
System.debug(isValid); // true

// Con caracteres especiales
Boolean isValid = PhoneValidator.isValidNumber('+34 (612) 345-678', 'ES');
System.debug(isValid); // true
```

### Países soportados

Los países soportados incluyen (entre otros):

| Código | País |
|--------|------|
| ES | España |
| US | Estados Unidos |
| MX | México |
| CO | Colombia |
| FR | Francia |
| GB | Reino Unido |
| AR | Argentina |
| CL | Chile |
| PE | Perú |
| BR | Brasil |
| DE | Alemania |
| IT | Italia |
| JP | Japón |
| CN | China |
| IN | India |
| KR | Corea del Sur |
| RU | Rusia |

**Nota**: Para ver la lista completa de países, consulta el archivo [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv).

## Personalización

### Agregar un nuevo país

1. Agrega el regex correspondiente en Salesforce CMDT (`PhoneNumberMetadata__mdt`):
   - `IsoCode__c`: Código ISO del país (ej: 'ES')
   - `CountryCode__c`: Prefijo telefónico (ej: 34)
   - `GeneralDescRegex__c`: Regex general para el país
   - `MobileRegex__c`: Regex específico para móviles
   - `FixedLineRegex__c`: Regex específico para fijos

2. Opcional: Agrega tests en [`PhoneValidator_Test.cls`](force-app/main/default/classes/PhoneValidator_Test.cls)

### Obtener los regex de libphonenumber

Los patrones regex se basan en [Google's libphonenumber](https://github.com/google/libphonenumber). Puedes generar nuevos patrones ejecutando:

```bash
python force-app/extract_xml_to_csv.py
```

Este script procesa los datos de libphonenumber y genera el archivo CSV con los regex.

## Ejecutar Tests

### Usando Salesforce CLI

```bash
# Ejecutar todos los tests
sf apex test run --class-names PhoneValidator_Test

# Ejecutar tests específicos
sf apex test run --class-names PhoneValidator_Test --tests "PhoneValidator_Test.testSpain_ValidMobileNumber"
```

### Desde VS Code

1. Abre la paleta de comandos (Cmd+Shift+P)
2. Busca "SFDX: Run Apex Tests"
3. Selecciona la clase `PhoneValidator_Test`

## Configuración del Proyecto

El archivo `sfdx-project.json` contiene la configuración del proyecto Salesforce DX.

### Pre-requisitos

- Salesforce CLI (sf)
- VS Code con extensiones Salesforce
- Cuenta de Salesforce con acceso a un org ( sandbox o production)

### Despliegue

```bash
# Autenticar con tu org
sf auth login

# Desplegar el proyecto
sf project deploy start

# Desplegar solo clases específicas
sf project deploy start --metadata force-app/main/default/classes/PhoneValidator.cls
```

## Arquitectura

### PhoneValidator.cls

La clase principal contiene:

- `isValidNumber(phoneNumber, isoCountryCode)`: Método público que valida un número
- `cleanNumber()`: Limpia caracteres no numéricos
- `matchesRegex()`: Valida contra un patrón regex
- `getMetadata()`: Obtiene metadatos del país (con cacheo)

### PhoneNumberMetadata__mdt

Custom Metadata Type que almacena los regex por país:

```
DeveloperName  | IsoCode__c | CountryCode__c | GeneralDescRegex__c | MobileRegex__c | FixedLineRegex__c
Region_ES      | ES         | 34              | [5-9]\d{8}          | 6\d{8}|...    | 9(?:69...)|...
```

## Licencia

Este proyecto utiliza patrones regex de [Google's libphonenumber](https://github.com/google/libphonenumber) bajo licencia Apache 2.0.

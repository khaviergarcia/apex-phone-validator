# Phone Validator - Salesforce Apex

## Last updated - 06-02-2026


[Español](#español) | [English](#english)


---

## Español

Valida números de teléfono para más de 200 países usando expresiones regulares de [google/libphonenumber](https://github.com/google/libphonenumber).

### Uso

```apex
// Con código de país
Boolean isValid = PhoneValidator.isValidNumber('+34612345678', 'ES');

// Sin código de país
Boolean isValid = PhoneValidator.isValidNumber('612345678', 'ES');

// Con caracteres especiales
Boolean isValid = PhoneValidator.isValidNumber('+34 (612) 345-678', 'ES');
```

### Archivos

- `PhoneValidator.cls` - Clase principal de validación
- `PhoneValidator_Test.cls` - Tests unitarios
- `PhoneNumberMetadata__mdt` - Metadatos con regex por país

### Tests

Ejecutar tests:
```bash
sf apex test run --class-names PhoneValidator_Test
```

Playground en Javascript [google/libphonenumber-playground](https://htmlpreview.github.io/?https://github.com/google/libphonenumber/blob/master/javascript/i18n/phonenumbers/demo-compiled.html)

### Despliegue

Para desplegar el proyecto en Salesforce:

```bash
# 1. Autenticar con tu org
sf auth login

# 2. Desplegar todo el proyecto
sf project deploy start
```

### Insertar datos del CSV

Para insertar los registros de [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) en Salesforce:

**Opción A: Usar script Python**
```bash
python force-app/extract_xml_to_csv.py
```

**Opción B: Usar Data Loader**
1. Descargar el archivo CSV
2. Usar Salesforce Data Loader
3. Seleccionar "Insert" para el objeto `PhoneNumberMetadata__mdt`
4. Mapear las columnas del CSV a los campos del objeto

**Opción C: Usar Workbench**
1. Acceder a [workbench.developerforce.com](https://workbench.developerforce.com)
2. Ir a "Migration" > "Insert"
3. Seleccionar objeto `PhoneNumberMetadata__mdt`
4. Subir el archivo CSV

### Países

Consulta [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) para la lista completa de países soportados.

---

## English

Validates phone numbers for 200+ countries using regular expressions from [google/libphonenumber](https://github.com/google/libphonenumber).

### Usage

```apex
// With country code
Boolean isValid = PhoneValidator.isValidNumber('+34612345678', 'ES');

// Without country code
Boolean isValid = PhoneValidator.isValidNumber('612345678', 'ES');

// With special characters
Boolean isValid = PhoneValidator.isValidNumber('+34 (612) 345-678', 'ES');
```

### Files

- `PhoneValidator.cls` - Main validation class
- `PhoneValidator_Test.cls` - Unit tests
- `PhoneNumberMetadata__mdt` - Metadata with regex by country

### Tests

Run tests:
```bash
sf apex test run --class-names PhoneValidator_Test
```

Playground en Javascript [google/libphonenumber-playground](https://htmlpreview.github.io/?https://github.com/google/libphonenumber/blob/master/javascript/i18n/phonenumbers/demo-compiled.html)

### Deployment

To deploy the project to Salesforce:

```bash
# 1. Authenticate with your org
sf auth login

# 2. Deploy the entire project
sf project deploy start
```

### Insert CSV Data

To insert records from [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) into Salesforce:

**Option A: Using Python Script**
```bash
python force-app/extract_xml_to_csv.py
```

**Option B: Using Data Loader**
1. Download the CSV file
2. Use Salesforce Data Loader
3. Select "Insert" for object `PhoneNumberMetadata__mdt`
4. Map CSV columns to object fields

**Option C: Using Workbench**
1. Go to [workbench.developerforce.com](https://workbench.developerforce.com)
2. Go to "Migration" > "Insert"
3. Select object `PhoneNumberMetadata__mdt`
4. Upload the CSV file

### Countries

See [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) for the complete list of supported countries.

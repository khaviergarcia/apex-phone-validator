# Phone Validator - Salesforce Apex

## Last updated - 06-02-2026


[Español](#español) | [English](#english)

---

## English

Validates phone numbers for over 200 countries using regular expressions from [google/libphonenumber](https://github.com/google/libphonenumber).

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
- `PhoneNumberMetadata__mdt` - Metadata with regex per country

### Tests

Run tests:
```bash
sf apex test run --class-names PhoneValidator_Test
```

Javascript Playground [google/libphonenumber-playground](https://htmlpreview.github.io/?https://github.com/google/libphonenumber/blob/master/javascript/i18n/phonenumbers/demo-compiled.html)


### Insert CSV Data

To insert records from [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) into Salesforce:

**Option A: Salesforce Inspector Extension**
1. Download the CSV file
2. Use Salesforce Inspector Extension
3. Select ToolingApi
4. Select "Insert" for the `PhoneNumberMetadata__mdt` object
5. Map CSV columns to object fields

**Option B: Use Data Loader**
1. Download the CSV file
2. Use Salesforce Data Loader
3. Select "Insert" for the `PhoneNumberMetadata__mdt` object
4. Map CSV columns to object fields

**Option C: Use Workbench**
1. Go to [workbench.developerforce.com](https://workbench.developerforce.com)
2. Navigate to "Migration" > "Insert"
3. Select the `PhoneNumberMetadata__mdt` object
4. Upload the CSV file

### Countries

Refer to [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) for the full list of supported countries. This list is based on the XML from the [google/libphonenumber](https://github.com/google/libphonenumber/blob/master/resources/PhoneNumberMetadata.xml) library.

---

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


### Insertar datos del CSV

Para insertar los registros de [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) en Salesforce:

**Opción A: Salesforce Inspector Extension**
1. Descargar el archivo CSV
2. Usar Salesforce Inspector Extension
3. Seleccionar ToolingApi
4. Seleccionar "Insert" para el objeto `PhoneNumberMetadata__mdt`
5. Mapear las columnas del CSV a los campos del objeto

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

Consulta [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) para la lista completa de países soportados. Esta lista se basa en el xml de la libreria [google/libphonenumber](https://github.com/google/libphonenumber/blob/master/resources/PhoneNumberMetadata.xml).




# Phone Validator - Salesforce Apex

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

Playground in javascript [google/libphonenumber-playground](https://htmlpreview.github.io/?https://github.com/google/libphonenumber/blob/master/javascript/i18n/phonenumbers/demo-compiled.html)

### Countries

See [`PhoneMetadata_Upload.csv`](PhoneMetadata_Upload.csv) for the complete list of supported countries.

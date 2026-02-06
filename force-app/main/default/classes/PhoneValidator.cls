//https://github.com/google/libphonenumber/blob/master/resources/PhoneNumberMetadata.xml
//https://github.com/google/libphonenumber
public class PhoneValidator {

    private static Map<String, PhoneNumberMetadata__mdt> metadataCache;

    /**
     * Valida un número de teléfono dado un código de país ISO (ej: 'ES')
     * Retorna true si es válido (Móvil o Fijo).
     */
    public static Boolean isValidNumber(String phoneNumber, String isoCountryCode) {
        if(String.isBlank(phoneNumber) || String.isBlank(isoCountryCode)) return false;

        PhoneNumberMetadata__mdt metadata = getMetadata(isoCountryCode);
        if(metadata == null){
            System.debug(LoggingLevel.ERROR, 'No se encontró metadata para: ' + isoCountryCode);
            return false;
        }

        // 1. Limpiar el número (quitar +, espacios, guiones)
        String cleanedNumber = cleanNumber(phoneNumber);
        
        // 2. Si el número empieza por el código de país (ej: 34666...), quitarlo
        // Google almacena los regex basados en el "National Number" (sin prefijo de país)
        String countryPrefix = String.valueOf(Integer.valueOf(metadata.CountryCode__c));
        if(cleanedNumber.startsWith(countryPrefix)){
            cleanedNumber = cleanedNumber.substring(countryPrefix.length());
        }

        // 3. Validación General (Optimización: Si falla esto, falla todo)
        if(!matchesRegex(cleanedNumber, metadata.GeneralDescRegex__c)){
            return false;
        }

        // 4. Validación Específica (Es movil O es fijo?)
        boolean isMobile = matchesRegex(cleanedNumber, metadata.MobileRegex__c);
        boolean isFixed = matchesRegex(cleanedNumber, metadata.FixedLineRegex__c);

        return isMobile || isFixed;
    }

    private static Boolean matchesRegex(String input, String regexPattern) {
        if(String.isBlank(regexPattern)) return false;
        // Importante: Google usa regex optimizado. A veces es necesario compilar.
        try {
            Pattern p = Pattern.compile(regexPattern);
            Matcher m = p.matcher(input);
            return m.matches();
        } catch(Exception e){
            System.debug('Error en Regex: ' + e.getMessage());
            return false;
        }
    }

    private static String cleanNumber(String input) {
        // Deja solo digitos
        return input.replaceAll('[^0-9]', '');
    }

    /**
     * @description Obtiene la metadata para un país dado su código ISO. Usa caching para optimizar.
     * @param  isoCode  Código de país ISO (ej: 'ES')
     * @return          Metadata del país o null si no se encuentra.
     */
    private static PhoneNumberMetadata__mdt getMetadata(String isoCode) {
        if (metadataCache == null) {
            metadataCache = new Map<String, PhoneNumberMetadata__mdt>();
      
            for(PhoneNumberMetadata__mdt m : [SELECT DeveloperName, IsoCode__c, CountryCode__c, 
                                                        GeneralDescRegex__c, MobileRegex__c, FixedLineRegex__c 
                                                FROM PhoneNumberMetadata__mdt
                                                WHERE IsoCode__c = :isoCode]) {
                metadataCache.put(m.IsoCode__c, m);
            }
        }
        return metadataCache.get(isoCode);
    }
}
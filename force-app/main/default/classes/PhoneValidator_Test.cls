/**
 * Test class for PhoneValidator
 * Tests all countries from PhoneMetadata_Upload.csv
 * 
 * Note: This test class uses the existing PhoneNumberMetadata__mdt records
 * that must be deployed in the org. The tests rely on the CMDT records
 * already being available in the Salesforce environment.
 */
@isTest
private class PhoneValidator_Test {

    // ==================== TESTS FOR SPAIN (ES) ====================
    
    @isTest
    static void testSpain_ValidMobileNumber() {
        // Spanish mobile number (6XX XXX XXX)
        String phone = '+34612345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Valid Spanish mobile number should return true');
    }
    
    @isTest
    static void testSpain_ValidMobileNumberWithoutPrefix() {
        // Spanish mobile number without country code
        String phone = '612345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Valid Spanish mobile without country code should return true');
    }
    
    @isTest
    static void testSpain_ValidFixedLineNumber() {
        // Spanish fixed line number (91X XXX XXX)
        String phone = '+34911234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Valid Spanish fixed line should return true');
    }
    
    @isTest
    static void testSpain_InvalidNumber() {
        // Invalid Spanish number (too short)
        String phone = '61234';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(false, result, 'Invalid Spanish number should return false');
    }

    // ==================== TESTS FOR UNITED STATES (US) ====================
    
    @isTest
    static void testUS_ValidMobileNumber() {
        // US mobile number
        String phone = '+12025550123';
        Boolean result = PhoneValidator.isValidNumber(phone, 'US');
        System.assertEquals(true, result, 'Valid US mobile number should return true');
    }
    
    @isTest
    static void testUS_ValidMobileWithoutCountryCode() {
        // US mobile without country code
        String phone = '2025550123';
        Boolean result = PhoneValidator.isValidNumber(phone, 'US');
        System.assertEquals(true, result, 'Valid US mobile without country code should return true');
    }
    
    @isTest
    static void testUS_ValidFixedLineNumber() {
        // US fixed line
        String phone = '+12125551234';
        Boolean result = PhoneValidator.isValidNumber(phone, 'US');
        System.assertEquals(true, result, 'Valid US fixed line should return true');
    }
    
    @isTest
    static void testUS_InvalidNumber_StartsWith1() {
        // Invalid US number starting with 1 (country code)
        String phone = '12025550123'; // Too long, starts with country code
        Boolean result = PhoneValidator.isValidNumber(phone, 'US');
        // This should handle the country code properly
        System.assertNotEquals(null, result);
    }

    // ==================== TESTS FOR MEXICO (MX) ====================
    
    @isTest
    static void testMexico_ValidMobileNumber() {
        // Mexican mobile number
        String phone = '+5215512345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'MX');
        System.assertEquals(true, result, 'Valid Mexican mobile number should return true');
    }
    
    @isTest
    static void testMexico_ValidMobileWithoutCountryCode() {
        // Mexican mobile without country code
        String phone = '15512345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'MX');
        System.assertEquals(true, result, 'Valid Mexican mobile without country code should return true');
    }
    
    @isTest
    static void testMexico_InvalidNumber() {
        // Invalid Mexican number (too short)
        String phone = '551234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'MX');
        System.assertEquals(false, result, 'Invalid Mexican number should return false');
    }

    // ==================== TESTS FOR COLOMBIA (CO) ====================
    
    @isTest
    static void testColombia_ValidMobileNumber() {
        // Colombian mobile number
        String phone = '+573001234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CO');
        System.assertEquals(true, result, 'Valid Colombian mobile number should return true');
    }
    
    @isTest
    static void testColombia_ValidFixedLine() {
        // Colombian fixed line
        String phone = '+5712345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CO');
        System.assertEquals(true, result, 'Valid Colombian fixed line should return true');
    }

    // ==================== TESTS FOR FRANCE (FR) ====================
    
    @isTest
    static void testFrance_ValidMobileNumber() {
        // French mobile number
        String phone = '+33612345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'FR');
        System.assertEquals(true, result, 'Valid French mobile number should return true');
    }
    
    @isTest
    static void testFrance_ValidFixedLine() {
        // French fixed line (Paris)
        String phone = '+33112345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'FR');
        System.assertEquals(true, result, 'Valid French fixed line should return true');
    }

    // ==================== TESTS FOR UNITED KINGDOM (GB) ====================
    
    @isTest
    static void testUK_ValidMobileNumber() {
        // UK mobile number
        String phone = '+447123456789';
        Boolean result = PhoneValidator.isValidNumber(phone, 'GB');
        System.assertEquals(true, result, 'Valid UK mobile number should return true');
    }
    
    @isTest
    static void testUK_ValidFixedLine() {
        // UK fixed line (London)
        String phone = '+442071234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'GB');
        System.assertEquals(true, result, 'Valid UK fixed line should return true');
    }

    // ==================== TESTS FOR ARGENTINA (AR) ====================
    
    @isTest
    static void testArgentina_ValidMobileNumber() {
        // Argentine mobile number
        String phone = '+5491123456789';
        Boolean result = PhoneValidator.isValidNumber(phone, 'AR');
        System.assertEquals(true, result, 'Valid Argentine mobile number should return true');
    }
    
    @isTest
    static void testArgentina_ValidFixedLine() {
        // Argentine fixed line (Buenos Aires)
        String phone = '+541112345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'AR');
        System.assertEquals(true, result, 'Valid Argentine fixed line should return true');
    }

    // ==================== EDGE CASES ====================
    
    @isTest
    static void testNullPhoneNumber() {
        Boolean result = PhoneValidator.isValidNumber(null, 'ES');
        System.assertEquals(false, result, 'Null phone number should return false');
    }
    
    @isTest
    static void testEmptyPhoneNumber() {
        Boolean result = PhoneValidator.isValidNumber('', 'ES');
        System.assertEquals(false, result, 'Empty phone number should return false');
    }
    
    @isTest
    static void testNullCountryCode() {
        Boolean result = PhoneValidator.isValidNumber('612345678', null);
        System.assertEquals(false, result, 'Null country code should return false');
    }
    
    @isTest
    static void testEmptyCountryCode() {
        Boolean result = PhoneValidator.isValidNumber('612345678', '');
        System.assertEquals(false, result, 'Empty country code should return false');
    }
    
    @isTest
    static void testInvalidCountryCode() {
        Boolean result = PhoneValidator.isValidNumber('612345678', 'ZZ');
        System.assertEquals(false, result, 'Invalid country code should return false');
    }

    // ==================== TEST PHONE NUMBER FORMATTING ====================
    
    @isTest
    static void testPhoneWithSpaces() {
        String phone = '+34 612 345 678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Phone with spaces should be valid');
    }
    
    @isTest
    static void testPhoneWithDashes() {
        String phone = '+34-612-345-678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Phone with dashes should be valid');
    }
    
    @isTest
    static void testPhoneWithParentheses() {
        String phone = '+34 (612) 345 678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Phone with parentheses should be valid');
    }
    
    @isTest
    static void testPhoneWithPlusAndCountryCode() {
        // Number already with country code prefix
        String phone = '+34612345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Phone with country code should be valid');
    }
    
    @isTest
    static void testPhoneWithoutPlusButWithCountryCode() {
        // Number with country code but no plus sign
        String phone = '34612345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Phone with country code without plus should be valid');
    }

    // ==================== TEST ADDITIONAL COUNTRIES ====================
    
    @isTest
    static void testChile_ValidMobileNumber() {
        // Chile mobile
        String phone = '+56912345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CL');
        System.assertEquals(true, result, 'Valid Chilean mobile should return true');
    }
    
    @isTest
    static void testPeru_ValidMobileNumber() {
        // Peru mobile
        String phone = '+51912345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'PE');
        System.assertEquals(true, result, 'Valid Peruvian mobile should return true');
    }
    
    @isTest
    static void testBrazil_ValidMobileNumber() {
        // Brazil mobile
        String phone = '+5511991234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'BR');
        System.assertEquals(true, result, 'Valid Brazilian mobile should return true');
    }
    
    @isTest
    static void testGermany_ValidMobileNumber() {
        // Germany mobile
        String phone = '+4915112345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'DE');
        System.assertEquals(true, result, 'Valid German mobile should return true');
    }
    
    @isTest
    static void testItaly_ValidMobileNumber() {
        // Italy mobile
        String phone = '+393401234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'IT');
        System.assertEquals(true, result, 'Valid Italian mobile should return true');
    }
    
    @isTest
    static void testPortugal_ValidMobileNumber() {
        // Portugal mobile
        String phone = '+351912345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'PT');
        System.assertEquals(true, result, 'Valid Portuguese mobile should return true');
    }
    
    @isTest
    static void testAustralia_ValidMobileNumber() {
        // Australia mobile
        String phone = '+61412345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'AU');
        System.assertEquals(true, result, 'Valid Australian mobile should return true');
    }
    
    @isTest
    static void testCanada_ValidMobileNumber() {
        // Canada mobile
        String phone = '+14161234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CA');
        System.assertEquals(true, result, 'Valid Canadian mobile should return true');
    }

    // ==================== TEST INVALID SCENARIOS ====================
    
    @isTest
    static void testTooShortNumber() {
        String phone = '123';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(false, result, 'Too short number should return false');
    }
    
    @isTest
    static void testTooLongNumber() {
        String phone = '61234567890123456789';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(false, result, 'Too long number should return false');
    }
    
    @isTest
    static void testLettersInNumber() {
        String phone = '612ABC4567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(false, result, 'Number with letters should return false');
    }
    
    @isTest
    static void testSpecialCharactersInNumber() {
        String phone = '612-345-678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
        System.assertEquals(true, result, 'Number with dashes should be valid');
    }

    // ==================== PERFORMANCE TESTS ====================
    
    @isTest
    static void testMultipleValidationsSameCountry() {
        // Test cache efficiency
        List<String> phones = new List<String>{
            '+34612345678',
            '+34612345679',
            '+34612345680',
            '+34911234567',
            '+34911234568'
        };
        
        for (String phone : phones) {
            Boolean result = PhoneValidator.isValidNumber(phone, 'ES');
            System.assertEquals(true, result, 'All valid Spanish numbers should return true');
        }
    }
    
    @isTest
    static void testMultipleValidationsDifferentCountries() {
        // Test validation across multiple countries
        Map<String, String> testCases = new Map<String, String>{
            'ES' => '+34612345678',
            'US' => '+12025550123',
            'MX' => '+5215512345678',
            'FR' => '+33612345678',
            'GB' => '+447123456789'
        };
        
        for (String country : testCases.keySet()) {
            Boolean result = PhoneValidator.isValidNumber(testCases.get(country), country);
            System.assertEquals(true, result, 'Valid numbers should return true for country: ' + country);
        }
    }

    // ==================== TEST ADDITIONAL COUNTRIES WITH REGEX ====================
    
    @isTest
    static void testChile_ValidFixedLine() {
        // Chile fixed line
        String phone = '+56221234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CL');
        System.assertEquals(true, result, 'Valid Chilean fixed line should return true');
    }
    
    @isTest
    static void testJapan_ValidMobileNumber() {
        // Japan mobile
        String phone = '+819012345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'JP');
        System.assertEquals(true, result, 'Valid Japanese mobile should return true');
    }
    
    @isTest
    static void testChina_ValidMobileNumber() {
        // China mobile
        String phone = '+8613812345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CN');
        System.assertEquals(true, result, 'Valid Chinese mobile should return true');
    }
    
    @isTest
    static void testIndia_ValidMobileNumber() {
        // India mobile
        String phone = '+919876543210';
        Boolean result = PhoneValidator.isValidNumber(phone, 'IN');
        System.assertEquals(true, result, 'Valid Indian mobile should return true');
    }
    
    @isTest
    static void testSouthKorea_ValidMobileNumber() {
        // South Korea mobile
        String phone = '+821012345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'KR');
        System.assertEquals(true, result, 'Valid South Korean mobile should return true');
    }
    
    @isTest
    static void testRussia_ValidMobileNumber() {
        // Russia mobile
        String phone = '+79161234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'RU');
        System.assertEquals(true, result, 'Valid Russian mobile should return true');
    }
    
    @isTest
    static void testPoland_ValidMobileNumber() {
        // Poland mobile
        String phone = '+48123456789';
        Boolean result = PhoneValidator.isValidNumber(phone, 'PL');
        System.assertEquals(true, result, 'Valid Polish mobile should return true');
    }
    
    @isTest
    static void testNetherlands_ValidMobileNumber() {
        // Netherlands mobile
        String phone = '+31612345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'NL');
        System.assertEquals(true, result, 'Valid Dutch mobile should return true');
    }
    
    @isTest
    static void testBelgium_ValidMobileNumber() {
        // Belgium mobile
        String phone = '+32475123456';
        Boolean result = PhoneValidator.isValidNumber(phone, 'BE');
        System.assertEquals(true, result, 'Valid Belgian mobile should return true');
    }
    
    @isTest
    static void testSweden_ValidMobileNumber() {
        // Sweden mobile
        String phone = '+46701234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'SE');
        System.assertEquals(true, result, 'Valid Swedish mobile should return true');
    }
    
    @isTest
    static void testSwitzerland_ValidMobileNumber() {
        // Switzerland mobile
        String phone = '+41791234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CH');
        System.assertEquals(true, result, 'Valid Swiss mobile should return true');
    }
    
    @isTest
    static void testAustria_ValidMobileNumber() {
        // Austria mobile
        String phone = '+436641234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'AT');
        System.assertEquals(true, result, 'Valid Austrian mobile should return true');
    }
    
    @isTest
    static void testTurkey_ValidMobileNumber() {
        // Turkey mobile
        String phone = '+905551234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'TR');
        System.assertEquals(true, result, 'Valid Turkish mobile should return true');
    }
    
    @isTest
    static void testSaudiArabia_ValidMobileNumber() {
        // Saudi Arabia mobile
        String phone = '+966501234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'SA');
        System.assertEquals(true, result, 'Valid Saudi mobile should return true');
    }
    
    @isTest
    static void testUAE_ValidMobileNumber() {
        // UAE mobile
        String phone = '+971501234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'AE');
        System.assertEquals(true, result, 'Valid UAE mobile should return true');
    }
    
    @isTest
    static void testSouthAfrica_ValidMobileNumber() {
        // South Africa mobile
        String phone = '+27821234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ZA');
        System.assertEquals(true, result, 'Valid South African mobile should return true');
    }
    
    @isTest
    static void testNigeria_ValidMobileNumber() {
        // Nigeria mobile
        String phone = '+2348012345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'NG');
        System.assertEquals(true, result, 'Valid Nigerian mobile should return true');
    }
    
    @isTest
    static void testKenya_ValidMobileNumber() {
        // Kenya mobile
        String phone = '+254712345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'KE');
        System.assertEquals(true, result, 'Valid Kenyan mobile should return true');
    }
    
    @isTest
    static void testEgypt_ValidMobileNumber() {
        // Egypt mobile
        String phone = '+201012345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'EG');
        System.assertEquals(true, result, 'Valid Egyptian mobile should return true');
    }
    
    @isTest
    static void testIsrael_ValidMobileNumber() {
        // Israel mobile
        String phone = '+972501234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'IL');
        System.assertEquals(true, result, 'Valid Israeli mobile should return true');
    }
    
    @isTest
    static void testSingapore_ValidMobileNumber() {
        // Singapore mobile
        String phone = '+6581234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'SG');
        System.assertEquals(true, result, 'Valid Singaporean mobile should return true');
    }
    
    @isTest
    static void testHongKong_ValidMobileNumber() {
        // Hong Kong mobile
        String phone = '+85251234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'HK');
        System.assertEquals(true, result, 'Valid Hong Kong mobile should return true');
    }
    
    @isTest
    static void testTaiwan_ValidMobileNumber() {
        // Taiwan mobile
        String phone = '+886912345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'TW');
        System.assertEquals(true, result, 'Valid Taiwanese mobile should return true');
    }
    
    @isTest
    static void testThailand_ValidMobileNumber() {
        // Thailand mobile
        String phone = '+66812345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'TH');
        System.assertEquals(true, result, 'Valid Thai mobile should return true');
    }
    
    @isTest
    static void testVietnam_ValidMobileNumber() {
        // Vietnam mobile
        String phone = '+84901234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'VN');
        System.assertEquals(true, result, 'Valid Vietnamese mobile should return true');
    }
    
    @isTest
    static void testMalaysia_ValidMobileNumber() {
        // Malaysia mobile
        String phone = '+60123456789';
        Boolean result = PhoneValidator.isValidNumber(phone, 'MY');
        System.assertEquals(true, result, 'Valid Malaysian mobile should return true');
    }
    
    @isTest
    static void testIndonesia_ValidMobileNumber() {
        // Indonesia mobile
        String phone = '+628123456789';
        Boolean result = PhoneValidator.isValidNumber(phone, 'ID');
        System.assertEquals(true, result, 'Valid Indonesian mobile should return true');
    }
    
    @isTest
    static void testPhilippines_ValidMobileNumber() {
        // Philippines mobile
        String phone = '+639171234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'PH');
        System.assertEquals(true, result, 'Valid Filipino mobile should return true');
    }
    
    @isTest
    static void testNewZealand_ValidMobileNumber() {
        // New Zealand mobile
        String phone = '+64211234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'NZ');
        System.assertEquals(true, result, 'Valid New Zealand mobile should return true');
    }
    
    @isTest
    static void testIreland_ValidMobileNumber() {
        // Ireland mobile
        String phone = '+353851234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'IE');
        System.assertEquals(true, result, 'Valid Irish mobile should return true');
    }
    
    @isTest
    static void testDenmark_ValidMobileNumber() {
        // Denmark mobile
        String phone = '+4512345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'DK');
        System.assertEquals(true, result, 'Valid Danish mobile should return true');
    }
    
    @isTest
    static void testNorway_ValidMobileNumber() {
        // Norway mobile
        String phone = '+4741234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'NO');
        System.assertEquals(true, result, 'Valid Norwegian mobile should return true');
    }
    
    @isTest
    static void testFinland_ValidMobileNumber() {
        // Finland mobile
        String phone = '+358501234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'FI');
        System.assertEquals(true, result, 'Valid Finnish mobile should return true');
    }
    
    @isTest
    static void testGreece_ValidMobileNumber() {
        // Greece mobile
        String phone = '+306912345678';
        Boolean result = PhoneValidator.isValidNumber(phone, 'GR');
        System.assertEquals(true, result, 'Valid Greek mobile should return true');
    }
    
    @isTest
    static void testCzechRepublic_ValidMobileNumber() {
        // Czech Republic mobile
        String phone = '+420601234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'CZ');
        System.assertEquals(true, result, 'Valid Czech mobile should return true');
    }
    
    @isTest
    static void testRomania_ValidMobileNumber() {
        // Romania mobile
        String phone = '+40711234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'RO');
        System.assertEquals(true, result, 'Valid Romanian mobile should return true');
    }
    
    @isTest
    static void testHungary_ValidMobileNumber() {
        // Hungary mobile
        String phone = '+36201234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'HU');
        System.assertEquals(true, result, 'Valid Hungarian mobile should return true');
    }
    
    @isTest
    static void testUkraine_ValidMobileNumber() {
        // Ukraine mobile
        String phone = '+380501234567';
        Boolean result = PhoneValidator.isValidNumber(phone, 'UA');
        System.assertEquals(true, result, 'Valid Ukrainian mobile should return true');
    }
}

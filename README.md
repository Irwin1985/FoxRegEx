# FoxRegEx

`FoxRegEx` is a Visual FoxPro Class library that wrappers the <code>RegEx</code> built-in object in VBScript.

<h2>Overview</h2>

`FoxRegEx` matches any string against special text pattern called `Regular Expression` and returns either an object or a cursor filled  with all the matches.

A regular expression is a string that describes a match pattern. The match pattern provides a template that can be used to test another string, the search string, for a matching sub-string. In its simplest form, the match pattern string is just a sequence of characters that must be matched. For example, the pattern "vfp" matches this exact sequence of characters and only this sequence. More sophisticated regular expressions can match against items such as file names, path names, and Internet URLs. Thus, the RegExp object is frequently used to validate data for correct form and syntax.

# Table of Contents

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Built-in RegEx](#formatters)
	- [URL](#foxfakerproviderbase)
	- [IPv4](#foxfakerproviderlorem)
	- [IPv6](#foxfakerprovideren_usperson)
	- [Email](#foxfakerprovideren_usaddress)
	- [Youtube Video ID](#foxfakerprovideren_usphonenumber)
	- [Youtube Channel ID](#foxfakerprovideren_uscompany)
	- [HTML Tag](#foxfakerproviderdatetime)
	- [Hex Color](#foxfakerproviderinternet)
	- [Date](#foxfakerproviderpayment)
- [License](#license)


## Installation

```
Just copy the FoxRegEx prg anywhere into your project PATH folder.
```

## Basic Usage

Use a **Public** Variable or a **_Screen Property** to instantiate `FoxFaker.prg` object.

```xBase
Public Faker
// require the FoxFaker Prg
Set Procedure to "FoxFaker" Additive

// Instantiate FoxFaker Object
Faker = NewObject("FoxFaker", "FoxFaker.prg")

// Generate data by accessing properties. 
// All methods are written using 'fake' as prefix
// for avoiding "Function Name" conflict, when calling Faker.name()

?Faker.fakeName() 	// 'Jhon Doe'

?Faker.fakeAddress() 	// "426 Jordy Lodge Cartwrightshire, SC 88120-6700"
?Faker.text()
  // Dolores sit sint laboriosam dolorem culpa et autem. Beatae nam sunt fugit
  // et sit et mollitia sed.
  // Fuga deserunt tempora facere magni omnis. Omnis quia temporibus laudantium
  // sit minima sint.
```
## Formatters

Each of the generator properties (like `name`, `address`, and `lorem`) are called "formatters". A faker generator has many of them, packaged in "providers". Here is a list of the bundled formatters in the default locale.

### `FoxFaker\Provider\Base`
```xBase
    fakeRandomDigit()             		// 9
    fakeRandomNumber(tnLength)  		// 16795371    
    fakeNumberBetween(tnLowVal, tnHighVal) 	// 1985
    fakeRandomLetter()          		// 'i'
```
### `FoxFaker\Provider\Lorem`
```xBase
    fakeWord()                            // 'aut'
    fakeWords(tnHowMany)                  // Laborum vero a officia id corporis.
    fakeSentence(tnHowMany)  		  // 'Sit vitae voluptas sint non voluptates.'
    fakeText(tnLength)                    // 'Fuga totam reiciendis qui architecto fugiat nemo.'
```
### `FoxFaker\Provider\en_US\Person`
```xBase
    fakeTitle(tcGender = null|'male'|'female') 	   // 'Ms.'
    fakeTitleMale()                                // 'Mr.'
    fakeTitleFemale()                              // 'Ms.'
    fakeSuffix()                                   // 'Jr.'
    fakeName(tcGender = null|'male'|'female')      // 'Dr. Zane Stroman'
    fakeFirstName(tcGender = null|'male'|'female') // 'Maynard'
    fakeFirstNameMale()                            // 'Maynard'
    fakeFirstNameFemale()                          // 'Rachel'
    fakeLastName()                                 // 'Zulauf'
```
### `FoxFaker\Provider\en_US\Address`
```xBase  
    fakeSecondaryAddress()	// 'Suite 961'
    fakeState()			// 'NewMexico'    
    fakeCity()			// 'West Judge'
    fakeStreetName()		// 'Keegan Trail'
    fakeStreetAddress()		// '439 Karley Loaf Suite 897'
    fakePostcode()		// '17916'
    fakeAddress()		// '8888 Cummings Vista Apt. 101, Susanbury, NY 95473'
    fakeCountry()		// 'Falkland Islands (Malvinas)'
    fakeLatitude()		// 77.147489
    fakeLongitude()		// 86.211205
```
### `FoxFaker\Provider\en_US\PhoneNumber`
```xBase
    fakePhoneNumber()           // '201-886-0269 x3767'
```
### `FoxFaker\Provider\en_US\Company`
```xBase
    fakeCompany()		// 'Bogan-Treutel'
    fakeJobTitle()		// 'Cashier'
```
### `FoxFaker\Provider\DateTime`
```xBase
    fakeDate()		// '1979-06-09'
    fakeTime() 		// '20:49:42'
    fakeAmPm()          // 'pm'
    fakeDayOfMonth()    // '04'
    fakeDayOfWeek()     // 'Friday'
    fakeMonth()         // '06'
    fakeMonthName()     // 'January'
    fakeYear()          // '1993'
```
### `FoxFaker\Provider\Internet`
```xBase
    fakeEmail()               // 'tkshlerin@collins.com'
    fakeSafeEmail()           // 'king.alford@example.org'
    fakeUserName()            // 'wade55'
    fakeDomain()              // 'wolffdeckow.net'
    fakeUrl()                 // 'http://www.skilesdonnelly.biz/aut-accusantium-ut-architecto-sit-et.html'
    fakeIpv4()                // '109.133.32.252'
    fakeLocalIpv4()           // '10.242.58.8'
    fakeIpv6()                // '8e65:933d:22ee:a232:f1c1:2741:1f10:117c'
    fakeMacAddress()          // '43:85:B7:08:10:CA'
```
### `FoxFaker\Provider\Payment`
```xBase
    fakeCreditCardType()          // 'MasterCard'
    fakeCreditCardNumber()        // '4485480221084675'
```
### `FoxFaker\Provider\Color`
```xBase
    fakeHexcolor()               // '#fa3cc2'
    fakeRgbcolor()               // '0,255,122'
    fakeColorName()              // 'Gainsbor'
```
### `FoxFaker\Provider\File`
```xBase
    fakeFileExtension()          // 'avi'
    fakeMimeType()               // 'video/x-msvideo'
```
### `FoxFaker\Provider\Uuid`
```xBase
    fakeUuid()                   // '7e57d004-2b97-0e7a-b45f-5387367791cd'
```
### `FoxFaker\Provider\Barcode`
```xBase
    fakeEan13()          // '4006381333931'
    fakeEan8()           // '73513537'
```
### `FoxFaker\Provider\Miscellaneous`
```xBase
    fakeBoolean() 	// .F.
    fakeMD5()           // 'de99a620c50f2990e87144735cd357e7'
    fakeSHA1()          // 'f08e7f04ca1a413807ebc47551a40a20a0b4de5c'
    fakeSHA256()        // '0061e4c60dac5c1d82db0135a42e00c89ae3a333e7c26485321f24348c7e98a5'
    fakeCountryCode()   // ES
    fakeCurrencyCode()  // EUR
```
## License

Faker is released under the MIT Licence.

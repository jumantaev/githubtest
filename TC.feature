@Component: Registration, Authorization, Cart
Feature: TC

    @Status:ToBeAutomated
    @Priority:Medium

    Scenario: 01 - Registration - 1 - Validate that USER is able to create account when all fields are populated with valid data

        Given user navigates by clicking https://litecart.stqa.ru/en/
        When user clicks 'Create new user' link
        And user enter '123456789' into 'Tax ID' field
        And user enter 'Sheldon' into 'Company' field
        And user enter 'Ivan' into 'First name' field
        And user enter 'Ivanov' into 'Last Name' field
        And user enter 'Ivanova st. 5' into 'Address 1' field
        And user enter '123456' into 'Postcode' field
        And user enter 'Moscow' into 'City' field
        And user select 'Russian Federation' in 'Country' dropdown
        And user enter 'test@test.com' into 'Email' field
        And user enter '123456' into 'Desired Password' field
        And user enter '123456' into 'Confirm Password' field
        And user clicks 'Create account' button
        Then redirecting to the Home page with message " Your customer account has been created"
        And message is green


    Scenario Outline: 02 - Registration - 2 Validate that USER is not able to create an account when all required fields (with "*") are populated with valid data except the field "Email" in which invalid data entered

        Given user navigates by clicking https://litecart.stqa.ru/en/
        When user clicks 'Create new user' link
        And user enter '123456789' into 'Tax ID' field
        And user enter 'Sheldon' into 'Company' field
        And user enter 'Ivan' into 'First name' field
        And user enter 'Ivanov' into 'Last Name' field
        And user enter 'Ivanova st. 5' into 'Address 1' field
        And user enter '123456' into 'Postcode' field
        And user enter 'Moscow' into 'City' field
        And user select 'Russian Federation' in 'Country' dropdown
        And user enter <email> into 'Email' field
        And user enter '123456' into 'Desired Password' field
        And user enter '123456' into 'Confirm Password' field
        And user clicks 'Create account' button
        Then tooltip of the 'Email' field  appears with text 'Enter valid email'
        And text is red
        Examples:
            | email                 |
            | @test.com             |
            | test@test             |
            | test @test.com        |
            | space + test@test.com |
            | test@test.com +space  |
            | test@@test.com        |
            | testtest.com          |
            | teавпр@test.com       |
            | !#@test.com           |
            | test@                 |
            | @                     |
            | space                 |


    Scenario: 03 - Authorization - Validate that authorization is availiable when all fields are populated with valid data

        Given user navigates by clicking https://litecart.stqa.ru/en/
        When user enter 'test@test.com' into 'email' field
        And user enter '123456' into 'Password' field
        And user click 'Login' button
        Then redirecting to the Home page with message "You are now logged in as Ivan Ivanov."
        And text is green


    Scenario: 04 - Cart - Validate that USER is able to add item to the Cart

        Given user navigates by clicking https://litecart.stqa.ru/en/
        When user clicks any item
        And user clicks 'Checkout' link
        Then redirecting to the Cart page
        And item which was added is displayed


    Scenario Outline: 05 - Cart - Validate that order total price increases correctly when item quantity is increased in the cart

        Given user navigates by clicking https://litecart.stqa.ru/en/
        When user clicks any item
        And user clicks 'Checkout' link
        And user enter <quantity> into 'Quantity' field
        Then Total price increased <number> times

        Examples:
            | quantity | number |
            | 2        | 2      |
            | 3        | 3      |
            | 4        | 4      |
            | 5        | 5      |
            | 6        | 6      |

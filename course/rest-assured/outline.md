# GIÁO TRÌNH API AUTOMATION TESTING VỚI REST ASSURED

## MỤC LỤC

### PHẦN 1: KHỞI ĐẦU
1. Giới thiệu Rest Assured
2. Cài đặt và cấu hình môi trường
3. Test case đầu tiên

### PHẦN 2: CƠ BẢN
4. Given-When-Then Pattern
5. HTTP Methods với Rest Assured
6. Request Configuration
7. Response Validation

### PHẦN 3: NÂNG CAO
8. Authentication & Authorization
9. File Upload/Download
10. Serialization & Deserialization
11. Request/Response Specifications

### PHẦN 4: FRAMEWORK DESIGN
12. Page Object Pattern cho API
13. Data-Driven Testing
14. Reporting & Logging
15. CI/CD Integration

---

## PHẦN 1: KHỞI ĐẦU

### Chương 1: Giới thiệu Rest Assured

#### 1.1 Rest Assured là gì?

Rest Assured là thư viện Java mạnh mẽ để test REST API với cú pháp BDD (Behavior-Driven Development) dễ đọc, dễ hiểu.

**Đặc điểm nổi bật:**
- Cú pháp Given-When-Then tự nhiên
- Hỗ trợ đầy đủ HTTP methods
- Validation mạnh mẽ với Hamcrest matchers
- Tích hợp tốt với TestNG, JUnit
- Hỗ trợ JSON/XML parsing
- Xử lý authentication dễ dàng

#### 1.2 Kiến trúc cơ bản

```java
given()
    .header("Content-Type", "application/json")
    .body(requestBody)
.when()
    .post("/users")
.then()
    .statusCode(201)
    .body("name", equalTo("John"));
```

**Giải thích:**
- **given()**: Chuẩn bị request (headers, params, body, auth)
- **when()**: Thực hiện HTTP method (GET, POST, PUT, DELETE, PATCH)
- **then()**: Validate response (status, headers, body)

---

### Chương 2: Cài đặt và cấu hình môi trường

#### 2.1 Yêu cầu hệ thống

```
- Java JDK 8 trở lên
- Maven hoặc Gradle
- IDE: IntelliJ IDEA (recommended), Eclipse, hoặc VS Code
```

#### 2.2 Tạo Maven Project

**Bước 1: Tạo cấu trúc thư mục**

```
api-automation/
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
│   └── test/
│       ├── java/
│       │   ├── tests/
│       │   ├── endpoints/
│       │   ├── models/
│       │   └── utils/
│       └── resources/
│           ├── config.properties
│           └── testdata/
├── pom.xml
└── testng.xml
```

**Bước 2: Cấu hình pom.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.apiautomation</groupId>
    <artifactId>rest-assured-framework</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <rest-assured.version>5.3.2</rest-assured.version>
        <testng.version>7.8.0</testng.version>
        <jackson.version>2.15.2</jackson.version>
        <allure.version>2.24.0</allure.version>
    </properties>

    <dependencies>
        <!-- Rest Assured -->
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>rest-assured</artifactId>
            <version>${rest-assured.version}</version>
        </dependency>

        <!-- JSON Schema Validator -->
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>json-schema-validator</artifactId>
            <version>${rest-assured.version}</version>
        </dependency>

        <!-- TestNG -->
        <dependency>
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <version>${testng.version}</version>
        </dependency>

        <!-- Jackson for JSON -->
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>${jackson.version}</version>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.30</version>
            <scope>provided</scope>
        </dependency>

        <!-- Java Faker -->
        <dependency>
            <groupId>com.github.javafaker</groupId>
            <artifactId>javafaker</artifactId>
            <version>1.0.2</version>
        </dependency>

        <!-- Allure Report -->
        <dependency>
            <groupId>io.qameta.allure</groupId>
            <artifactId>allure-testng</artifactId>
            <version>${allure.version}</version>
        </dependency>

        <!-- ExtentReports -->
        <dependency>
            <groupId>com.aventstack</groupId>
            <artifactId>extentreports</artifactId>
            <version>5.1.1</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.1.2</version>
                <configuration>
                    <suiteXmlFiles>
                        <suiteXmlFile>testng.xml</suiteXmlFile>
                    </suiteXmlFiles>
                </configuration>
            </plugin>

            <!-- Allure Maven Plugin -->
            <plugin>
                <groupId>io.qameta.allure</groupId>
                <artifactId>allure-maven</artifactId>
                <version>2.12.0</version>
            </plugin>
        </plugins>
    </build>
</project>
```

**Bước 3: Cấu hình testng.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE suite SYSTEM "http://testng.org/testng-1.0.dtd">
<suite name="API Automation Suite" parallel="tests" thread-count="3">
    
    <listeners>
        <listener class-name="utils.ExtentReportListener"/>
    </listeners>
    
    <test name="User API Tests">
        <classes>
            <class name="tests.UserTests"/>
        </classes>
    </test>
    
    <test name="Post API Tests">
        <classes>
            <class name="tests.PostTests"/>
        </classes>
    </test>
    
</suite>
```

#### 2.3 Cấu hình file properties

**config.properties:**
```properties
# Base URL
base.url=https://jsonplaceholder.typicode.com

# Timeouts
connection.timeout=5000
socket.timeout=5000

# Logging
enable.request.logging=true
enable.response.logging=true

# Report
report.path=test-output/reports
screenshot.path=test-output/screenshots

# Environment
environment=QA
```

#### 2.4 Verify installation

```bash
# Build project
mvn clean install

# Run tests
mvn test

# Generate Allure report
mvn allure:report
mvn allure:serve
```

---

### Chương 3: Test case đầu tiên

#### 3.1 Simple GET Request

```java
package tests;

import io.restassured.RestAssured;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

public class FirstTest {
    
    @BeforeClass
    public void setup() {
        RestAssured.baseURI = "https://jsonplaceholder.typicode.com";
    }
    
    @Test
    public void testGetAllUsers() {
        given()
            .log().all()
        .when()
            .get("/users")
        .then()
            .log().all()
            .statusCode(200)
            .body("size()", equalTo(10));
    }
    
    @Test
    public void testGetUserById() {
        given()
            .pathParam("id", 1)
        .when()
            .get("/users/{id}")
        .then()
            .statusCode(200)
            .body("id", equalTo(1))
            .body("name", equalTo("Leanne Graham"))
            .body("email", containsString("@"));
    }
}
```

**Run test:**
```bash
mvn test -Dtest=FirstTest
```

#### 3.2 Giải thích chi tiết

**Logging:**
```java
.log().all()          // Log tất cả
.log().ifValidationFails()  // Log khi validation fail
.log().body()         // Log body only
.log().headers()      // Log headers only
.log().params()       // Log parameters only
```

**Path Parameters:**
```java
given()
    .pathParam("id", 1)
.when()
    .get("/users/{id}")
```

**Query Parameters:**
```java
given()
    .queryParam("userId", 1)
    .queryParam("postId", 5)
.when()
    .get("/comments")
```

**Multiple Assertions:**
```java
.then()
    .statusCode(200)
    .contentType("application/json")
    .body("id", equalTo(1))
    .body("name", notNullValue())
    .body("email", containsString("@"));
```

---

## PHẦN 2: CƠ BẢN

### Chương 4: Given-When-Then Pattern

#### 4.1 Given - Chuẩn bị Request

**Headers:**
```java
given()
    .header("Content-Type", "application/json")
    .header("Authorization", "Bearer token123")
    .header("Accept", "application/json")
```

**Multiple Headers:**
```java
Map<String, String> headers = new HashMap<>();
headers.put("Content-Type", "application/json");
headers.put("Authorization", "Bearer token123");

given()
    .headers(headers)
```

**Query Parameters:**
```java
given()
    .queryParam("userId", 1)
    .queryParam("page", 1)
    .queryParam("limit", 10)
```

**Multiple Query Params:**
```java
Map<String, Object> queryParams = new HashMap<>();
queryParams.put("userId", 1);
queryParams.put("page", 1);

given()
    .queryParams(queryParams)
```

**Path Parameters:**
```java
given()
    .pathParam("userId", 1)
    .pathParam("postId", 5)
.when()
    .get("/users/{userId}/posts/{postId}")
```

**Request Body:**
```java
// JSON String
String body = """
    {
        "name": "John Doe",
        "email": "john@example.com"
    }
    """;

given()
    .body(body)

// HashMap
Map<String, Object> body = new HashMap<>();
body.put("name", "John Doe");
body.put("email", "john@example.com");

given()
    .body(body)

// POJO
User user = new User("John Doe", "john@example.com");

given()
    .body(user)
```

#### 4.2 When - Thực hiện Request

**GET:**
```java
.when()
    .get("/users")
    .get("/users/{id}")
```

**POST:**
```java
.when()
    .post("/users")
```

**PUT:**
```java
.when()
    .put("/users/{id}")
```

**PATCH:**
```java
.when()
    .patch("/users/{id}")
```

**DELETE:**
```java
.when()
    .delete("/users/{id}")
```

#### 4.3 Then - Validate Response

**Status Code:**
```java
.then()
    .statusCode(200)
    .statusCode(is(200))
    .statusLine("HTTP/1.1 200 OK")
```

**Headers:**
```java
.then()
    .header("Content-Type", "application/json")
    .header("Server", notNullValue())
    .headers("Content-Type", "application/json",
             "Connection", "keep-alive")
```

**Body:**
```java
.then()
    .body("id", equalTo(1))
    .body("name", notNullValue())
    .body("email", containsString("@"))
    .body("size()", greaterThan(0))
```

**Response Time:**
```java
.then()
    .time(lessThan(2000L))  // milliseconds
    .time(lessThan(2L, TimeUnit.SECONDS))
```

---

### Chương 5: HTTP Methods với Rest Assured

#### 5.1 GET Request Examples

**Example 1: GET tất cả resources**
```java
@Test
public void testGetAllUsers() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .statusCode(200)
        .body("size()", equalTo(10))
        .body("id", hasItems(1, 2, 3))
        .body("name", everyItem(notNullValue()));
}
```

**Example 2: GET với path parameter**
```java
@Test
public void testGetUserById() {
    int userId = 1;
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .pathParam("id", userId)
    .when()
        .get("/users/{id}")
    .then()
        .statusCode(200)
        .body("id", equalTo(userId))
        .body("name", equalTo("Leanne Graham"))
        .body("address.city", equalTo("Gwenborough"));
}
```

**Example 3: GET với query parameters**
```java
@Test
public void testGetPostsByUserId() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .queryParam("userId", 1)
    .when()
        .get("/posts")
    .then()
        .statusCode(200)
        .body("userId", everyItem(equalTo(1)))
        .body("size()", greaterThan(0));
}
```

**Example 4: GET với multiple query params**
```java
@Test
public void testGetWithMultipleParams() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .queryParam("userId", 1)
        .queryParam("id", 1)
    .when()
        .get("/posts")
    .then()
        .statusCode(200)
        .body("[0].userId", equalTo(1))
        .body("[0].id", equalTo(1));
}
```

#### 5.2 POST Request Examples

**Example 1: POST với JSON string**
```java
@Test
public void testCreateUserWithJsonString() {
    String requestBody = """
        {
            "name": "Nguyen Van A",
            "username": "nguyenvana",
            "email": "nguyenvana@example.com",
            "phone": "0901234567",
            "website": "nguyenvana.com"
        }
        """;
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType("application/json")
        .body(requestBody)
    .when()
        .post("/users")
    .then()
        .statusCode(201)
        .body("name", equalTo("Nguyen Van A"))
        .body("email", equalTo("nguyenvana@example.com"))
        .body("id", notNullValue());
}
```

**Example 2: POST với HashMap**
```java
@Test
public void testCreateUserWithHashMap() {
    Map<String, Object> requestBody = new HashMap<>();
    requestBody.put("name", "Tran Thi B");
    requestBody.put("username", "tranthib");
    requestBody.put("email", "tranthib@example.com");
    requestBody.put("phone", "0907654321");
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .body(requestBody)
    .when()
        .post("/users")
    .then()
        .statusCode(201)
        .body("name", equalTo("Tran Thi B"));
}
```

**Example 3: POST với nested JSON**
```java
@Test
public void testCreateUserWithNestedJson() {
    Map<String, Object> address = new HashMap<>();
    address.put("street", "123 Main St");
    address.put("city", "Hanoi");
    address.put("zipcode", "100000");
    
    Map<String, Object> user = new HashMap<>();
    user.put("name", "Le Van C");
    user.put("email", "levanc@example.com");
    user.put("address", address);
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .body(user)
    .when()
        .post("/users")
    .then()
        .statusCode(201)
        .body("address.city", equalTo("Hanoi"));
}
```

**Example 4: POST với POJO**
```java
// User.java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String name;
    private String username;
    private String email;
    private String phone;
    private String website;
}

// Test
@Test
public void testCreateUserWithPOJO() {
    User user = new User(
        "Pham Thi D",
        "phamthid",
        "phamthid@example.com",
        "0909999999",
        "phamthid.com"
    );
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .body(user)
    .when()
        .post("/users")
    .then()
        .statusCode(201)
        .body("name", equalTo("Pham Thi D"));
}
```

#### 5.3 PUT Request Examples

**Example 1: PUT - Update toàn bộ resource**
```java
@Test
public void testUpdateUserCompletely() {
    String requestBody = """
        {
            "id": 1,
            "name": "Updated Name",
            "username": "updateduser",
            "email": "updated@example.com",
            "phone": "0912345678",
            "website": "updated.com"
        }
        """;
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .pathParam("id", 1)
        .body(requestBody)
    .when()
        .put("/users/{id}")
    .then()
        .statusCode(200)
        .body("name", equalTo("Updated Name"))
        .body("email", equalTo("updated@example.com"));
}
```

**Example 2: PUT với POJO**
```java
@Test
public void testUpdateUserWithPOJO() {
    User updatedUser = new User(
        "New Name",
        "newusername",
        "newemail@example.com",
        "0999999999",
        "newwebsite.com"
    );
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .pathParam("id", 1)
        .body(updatedUser)
    .when()
        .put("/users/{id}")
    .then()
        .statusCode(200);
}
```

#### 5.4 PATCH Request Examples

**Example 1: PATCH - Update một phần**
```java
@Test
public void testPartialUpdateUser() {
    Map<String, Object> updates = new HashMap<>();
    updates.put("name", "Partially Updated Name");
    updates.put("email", "partiallly@example.com");
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .pathParam("id", 1)
        .body(updates)
    .when()
        .patch("/users/{id}")
    .then()
        .statusCode(200)
        .body("name", equalTo("Partially Updated Name"));
}
```

**Example 2: PATCH chỉ một field**
```java
@Test
public void testUpdateOnlyEmail() {
    String requestBody = """
        {
            "email": "newemail@example.com"
        }
        """;
    
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .pathParam("id", 1)
        .body(requestBody)
    .when()
        .patch("/users/{id}")
    .then()
        .statusCode(200);
}
```

#### 5.5 DELETE Request Examples

**Example 1: DELETE resource**
```java
@Test
public void testDeleteUser() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .pathParam("id", 1)
    .when()
        .delete("/users/{id}")
    .then()
        .statusCode(200);
}
```

**Example 2: DELETE và verify**
```java
@Test
public void testDeleteAndVerify() {
    int userId = 1;
    
    // Delete user
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .pathParam("id", userId)
    .when()
        .delete("/users/{id}")
    .then()
        .statusCode(200);
    
    // Verify user không còn tồn tại (thực tế API demo vẫn trả về)
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .pathParam("id", userId)
    .when()
        .get("/users/{id}")
    .then()
        .statusCode(anyOf(is(404), is(200)));  // Demo API vẫn trả 200
}
```

---

### Chương 6: Request Configuration

#### 6.1 Content Type

```java
// Method 1
given()
    .contentType("application/json")

// Method 2
given()
    .contentType(ContentType.JSON)

// Method 3
given()
    .header("Content-Type", "application/json")
```

**Các Content Type phổ biến:**
```java
ContentType.JSON        // application/json
ContentType.XML         // application/xml
ContentType.HTML        // text/html
ContentType.TEXT        // text/plain
ContentType.URLENC      // application/x-www-form-urlencoded
ContentType.MULTIPART   // multipart/form-data
```

#### 6.2 Form Parameters

```java
@Test
public void testFormParameters() {
    given()
        .baseUri("https://httpbin.org")
        .contentType(ContentType.URLENC)
        .formParam("username", "testuser")
        .formParam("password", "testpass")
    .when()
        .post("/post")
    .then()
        .statusCode(200)
        .body("form.username", equalTo("testuser"));
}
```

#### 6.3 Multipart Form Data

```java
@Test
public void testMultipartForm() {
    given()
        .baseUri("https://httpbin.org")
        .multiPart("file", new File("path/to/file.txt"))
        .multiPart("name", "John Doe")
        .multiPart("email", "john@example.com")
    .when()
        .post("/post")
    .then()
        .statusCode(200);
}
```

#### 6.4 Cookies

```java
// Single cookie
given()
    .cookie("session_id", "abc123")

// Multiple cookies
given()
    .cookie("cookie1", "value1")
    .cookie("cookie2", "value2")

// Cookie object
Cookie cookie = new Cookie.Builder("session_id", "abc123")
    .setDomain("example.com")
    .setPath("/")
    .build();

given()
    .cookie(cookie)
```

#### 6.5 Base Path

```java
@BeforeClass
public void setup() {
    RestAssured.baseURI = "https://api.example.com";
    RestAssured.basePath = "/v1";
}

@Test
public void test() {
    // Actual URL: https://api.example.com/v1/users
    given()
    .when()
        .get("/users")
    .then()
        .statusCode(200);
}
```

#### 6.6 Timeouts

```java
given()
    .config(RestAssuredConfig.config()
        .httpClient(HttpClientConfig.httpClientConfig()
            .setParam(CoreConnectionPNames.CONNECTION_TIMEOUT, 5000)
            .setParam(CoreConnectionPNames.SO_TIMEOUT, 5000)))
```

#### 6.7 Proxy

```java
given()
    .proxy("proxy.example.com", 8080)
// hoặc
given()
    .proxy(host("proxy.example.com").withPort(8080))
```

#### 6.8 SSL/TLS Configuration

```java
// Bỏ qua SSL certificate validation (chỉ dùng cho test)
given()
    .relaxedHTTPSValidation()

// Hoặc
RestAssured.useRelaxedHTTPSValidation();
```

---

### Chương 7: Response Validation

#### 7.1 Status Code Validation

```java
.then()
    .statusCode(200)
    .statusCode(is(200))
    .statusCode(oneOf(200, 201, 202))
    .statusCode(anyOf(is(200), is(201)))
    .statusCode(allOf(greaterThanOrEqualTo(200), lessThan(300)))
```

#### 7.2 Header Validation

```java
.then()
    // Single header
    .header("Content-Type", "application/json")
    .header("Content-Type", containsString("json"))
    .header("Server", notNullValue())
    
    // Multiple headers
    .headers("Content-Type", "application/json",
             "Connection", "keep-alive")
    
    // Header exists
    .header("X-Custom-Header", notNullValue())
```

#### 7.3 Body Validation - Basic

**Single field:**
```java
.then()
    .body("id", equalTo(1))
    .body("name", equalTo("John Doe"))
    .body("email", containsString("@"))
    .body("age", greaterThan(18))
    .body("isActive", is(true))
```

**Null checks:**
```java
.then()
    .body("name", notNullValue())
    .body("deletedAt", nullValue())
```

**String matching:**
```java
.then()
    .body("name", equalTo("John"))
    .body("name", containsString("John"))
    .body("email", endsWith("@example.com"))
    .body("email", startsWith("john"))
    .body("status", equalToIgnoringCase("ACTIVE"))
```

#### 7.4 Body Validation - Nested Objects

```java
@Test
public void testNestedObjectValidation() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users/1")
    .then()
        .statusCode(200)
        // Nested object fields
        .body("address.street", equalTo("Kulas Light"))
        .body("address.city", equalTo("Gwenborough"))
        .body("address.geo.lat", equalTo("-37.3159"))
        .body("address.geo.lng", equalTo("81.1496"))
        
        // Company nested object
        .body("company.name", notNullValue())
        .body("company.catchPhrase", containsString("Multi"));
}
```

#### 7.5 Body Validation - Arrays

**Array size:**
```java
.then()
    .body("size()", equalTo(10))
    .body("size()", greaterThan(0))
    .body("isEmpty()", is(false))
```

**Array contains:**
```java
.then()
    .body("id", hasItems(1, 2, 3))
    .body("name", hasItem("John Doe"))
    .body("", hasSize(10))
```

**All items validation:**
```java
.then()
    .body("id", everyItem(notNullValue()))
    .body("age", everyItem(greaterThan(0)))
    .body("email", everyItem(containsString("@")))
```

**Specific array element:**
```java
.then()
    // First element
    .body("[0].id", equalTo(1))
    .body("[0].name", equalTo("Leanne Graham"))
    
    // Last element
    .body("[-1].id", equalTo(10))
    
    // Second element
    .body("[1].name", notNullValue())
```

#### 7.6 Body Validation - Complex Arrays

```java
@Test
public void testComplexArrayValidation() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .statusCode(200)
        
        // All users have valid structure
        .body("id", everyItem(notNullValue()))
        .body("name", everyItem(notNullValue()))
        .body("email", everyItem(containsString("@")))
        
        // Nested arrays
        .body("address.geo.lat", everyItem(notNullValue()))
        
        // Find specific item
        .body("find { it.id == 1 }.name", equalTo("Leanne Graham"))
        .body("find { it.username == 'Bret' }.email", 
              equalTo("Sincere@april.biz"))
        
        // FindAll - filter items
        .body("findAll { it.id > 5 }.size()", equalTo(5))
        .body("findAll { it.name.contains('Mrs') }.size()", greaterThan(0));
}
```

#### 7.7 Response Time Validation

```java
import static java.util.concurrent.TimeUnit.*;

.then()
    .time(lessThan(2000L))  // milliseconds
    .time(lessThan(2L), SECONDS)
    .time(greaterThan(100L))
    .time(both(greaterThan(100L)).and(lessThan(5000L)))
```

#### 7.8 Hamcrest Matchers Reference

```java
import static org.hamcrest.Matchers.*;

// Equality
equalTo(value)
not(equalTo(value))
is(value)

// Null
nullValue()
notNullValue()

// String
containsString("text")
containsStringIgnoringCase("TEXT")
startsWith("prefix")
endsWith("suffix")
equalToIgnoringCase("text")
equalToIgnoringWhiteSpace("text")
matchesPattern("regex")

// Numbers
greaterThan(10)
greaterThanOrEqualTo(10)
lessThan(100)
lessThanOrEqualTo(100)
closeTo(10.0, 0.5)  // value ± delta

// Collections
hasSize(5)
hasItem(value)
hasItems(value1, value2)
contains(value1, value2)  // exact order
containsInAnyOrder(value1, value2)
everyItem(matcher)
empty()
not(empty())

// Boolean
is(true)
is(false)

// Combined
allOf(matcher1, matcher2)  // AND
anyOf(matcher1, matcher2)  // OR
both(matcher1).and(matcher2)
either(matcher1).or(matcher2)
```

#### 7.9 Extract Response Data

**Extract as String:**
```java
@Test
public void testExtractResponse() {
    String jsonResponse = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users/1")
    .then()
        .statusCode(200)
        .extract()
        .asString();
    
    System.out.println("Response: " + jsonResponse);
}
```

**Extract specific values:**
```java
@Test
public void testExtractValues() {
    Response response = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users/1")
    .then()
        .statusCode(200)
        .extract()
        .response();
    
    // Extract single values
    int id = response.path("id");
    String name = response.path("name");
    String city = response.path("address.city");
    
    System.out.println("ID: " + id);
    System.out.println("Name: " + name);
    System.out.println("City: " + city);
    
    // Assert extracted values
    Assert.assertEquals(id, 1);
    Assert.assertNotNull(name);
}
```

**Extract from array:**
```java
@Test
public void testExtractFromArray() {
    Response response = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .extract()
        .response();
    
    // Extract list
    List<Integer> ids = response.jsonPath().getList("id");
    List<String> names = response.jsonPath().getList("name");
    
    System.out.println("IDs: " + ids);
    System.out.println("Names: " + names);
    
    // Get specific item
    String firstUserName = response.jsonPath().getString("[0].name");
    System.out.println("First user: " + firstUserName);
}
```

**Extract as POJO:**
```java
@Test
public void testExtractAsPOJO() {
    User user = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users/1")
    .then()
        .statusCode(200)
        .extract()
        .as(User.class);
    
    System.out.println("User: " + user.getName());
    System.out.println("Email: " + user.getEmail());
    
    Assert.assertEquals(user.getId(), Integer.valueOf(1));
}
```

---

## PHẦN 3: NÂNG CAO

### Chương 8: Authentication & Authorization

#### 8.1 Basic Authentication

```java
@Test
public void testBasicAuth() {
    given()
        .baseUri("https://httpbin.org")
        .auth()
        .basic("user", "password")
    .when()
        .get("/basic-auth/user/password")
    .then()
        .statusCode(200)
        .body("authenticated", is(true))
        .body("user", equalTo("user"));
}
```

**Preemptive Basic Auth:**
```java
@Test
public void testPreemptiveBasicAuth() {
    given()
        .baseUri("https://httpbin.org")
        .auth()
        .preemptive()
        .basic("user", "password")
    .when()
        .get("/basic-auth/user/password")
    .then()
        .statusCode(200);
}
```

#### 8.2 Bearer Token Authentication

```java
@Test
public void testBearerToken() {
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";
    
    given()
        .baseUri("https://api.example.com")
        .header("Authorization", "Bearer " + token)
    .when()
        .get("/protected-resource")
    .then()
        .statusCode(200);
}
```

**Với auth() method:**
```java
@Test
public void testBearerTokenAuth() {
    String token = "your_access_token";
    
    given()
        .baseUri("https://api.example.com")
        .auth()
        .oauth2(token)
    .when()
        .get("/protected-resource")
    .then()
        .statusCode(200);
}
```

#### 8.3 OAuth 2.0 Full Flow

```java
public class OAuth2Test {
    private String accessToken;
    
    @BeforeClass
    public void getAccessToken() {
        // Step 1: Get access token
        accessToken = given()
            .baseUri("https://oauth.example.com")
            .contentType(ContentType.URLENC)
            .formParam("grant_type", "client_credentials")
            .formParam("client_id", "your_client_id")
            .formParam("client_secret", "your_client_secret")
            .formParam("scope", "read write")
        .when()
            .post("/oauth/token")
        .then()
            .statusCode(200)
            .extract()
            .path("access_token");
        
        System.out.println("Access Token: " + accessToken);
    }
    
    @Test
    public void testWithAccessToken() {
        // Step 2: Use access token
        given()
            .baseUri("https://api.example.com")
            .header("Authorization", "Bearer " + accessToken)
        .when()
            .get("/protected-resource")
        .then()
            .statusCode(200)
            .body("data", notNullValue());
    }
    
    @Test
    public void testRefreshToken() {
        String refreshToken = "your_refresh_token";
        
        String newAccessToken = given()
            .baseUri("https://oauth.example.com")
            .contentType(ContentType.URLENC)
            .formParam("grant_type", "refresh_token")
            .formParam("refresh_token", refreshToken)
            .formParam("client_id", "your_client_id")
            .formParam("client_secret", "your_client_secret")
        .when()
            .post("/oauth/token")
        .then()
            .statusCode(200)
            .extract()
            .path("access_token");
        
        System.out.println("New Access Token: " + newAccessToken);
    }
}
```

#### 8.4 API Key Authentication

```java
@Test
public void testApiKeyInHeader() {
    given()
        .baseUri("https://api.example.com")
        .header("X-API-Key", "your_api_key_here")
    .when()
        .get("/data")
    .then()
        .statusCode(200);
}

@Test
public void testApiKeyInQueryParam() {
    given()
        .baseUri("https://api.example.com")
        .queryParam("api_key", "your_api_key_here")
    .when()
        .get("/data")
    .then()
        .statusCode(200);
}
```

#### 8.5 Digest Authentication

```java
@Test
public void testDigestAuth() {
    given()
        .baseUri("https://httpbin.org")
        .auth()
        .digest("user", "password")
    .when()
        .get("/digest-auth/auth/user/password")
    .then()
        .statusCode(200);
}
```

#### 8.6 Custom Authentication Token Manager

```java
public class TokenManager {
    private static String accessToken;
    private static String refreshToken;
    private static LocalDateTime tokenExpiry;
    
    public static String getValidToken() {
        if (accessToken == null || isTokenExpired()) {
            refreshAccessToken();
        }
        return accessToken;
    }
    
    private static boolean isTokenExpired() {
        return tokenExpiry == null || LocalDateTime.now().isAfter(tokenExpiry);
    }
    
    private static void refreshAccessToken() {
        Response response = given()
            .baseUri("https://oauth.example.com")
            .contentType(ContentType.URLENC)
            .formParam("grant_type", "client_credentials")
            .formParam("client_id", "client_id")
            .formParam("client_secret", "client_secret")
        .when()
            .post("/oauth/token")
        .then()
            .statusCode(200)
            .extract()
            .response();
        
        accessToken = response.path("access_token");
        int expiresIn = response.path("expires_in");
        tokenExpiry = LocalDateTime.now().plusSeconds(expiresIn - 60);
        
        System.out.println("Token refreshed. Expires at: " + tokenExpiry);
    }
}

// Sử dụng trong test
@Test
public void testWithTokenManager() {
    given()
        .baseUri("https://api.example.com")
        .header("Authorization", "Bearer " + TokenManager.getValidToken())
    .when()
        .get("/protected-resource")
    .then()
        .statusCode(200);
}
```

---

### Chương 9: File Upload/Download

#### 9.1 Single File Upload

```java
@Test
public void testSingleFileUpload() {
    File file = new File("src/test/resources/testdata/sample.txt");
    
    given()
        .baseUri("https://httpbin.org")
        .multiPart("file", file)
    .when()
        .post("/post")
    .then()
        .statusCode(200)
        .body("files", notNullValue());
}
```

#### 9.2 Multiple Files Upload

```java
@Test
public void testMultipleFilesUpload() {
    File file1 = new File("src/test/resources/testdata/file1.txt");
    File file2 = new File("src/test/resources/testdata/file2.txt");
    
    given()
        .baseUri("https://httpbin.org")
        .multiPart("file1", file1)
        .multiPart("file2", file2)
    .when()
        .post("/post")
    .then()
        .statusCode(200);
}
```

#### 9.3 File Upload với Additional Data

```java
@Test
public void testFileUploadWithData() {
    File file = new File("src/test/resources/testdata/document.pdf");
    
    given()
        .baseUri("https://httpbin.org")
        .multiPart("file", file, "application/pdf")
        .multiPart("title", "Test Document")
        .multiPart("description", "This is a test file")
        .multiPart("category", "testing")
    .when()
        .post("/post")
    .then()
        .statusCode(200)
        .body("form.title", equalTo("Test Document"));
}
```

#### 9.4 File Upload với Custom Content Type

```java
@Test
public void testFileUploadWithContentType() {
    File jsonFile = new File("src/test/resources/testdata/data.json");
    
    given()
        .baseUri("https://httpbin.org")
        .multiPart("file", jsonFile, "application/json")
    .when()
        .post("/post")
    .then()
        .statusCode(200);
}
```

#### 9.5 File Download

```java
@Test
public void testFileDownload() {
    byte[] fileBytes = given()
        .baseUri("https://httpbin.org")
    .when()
        .get("/image/png")
    .then()
        .statusCode(200)
        .extract()
        .asByteArray();
    
    // Save to file
    try {
        Files.write(
            Paths.get("target/downloaded-image.png"), 
            fileBytes
        );
        System.out.println("File downloaded successfully");
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

#### 9.6 Download và Validate File

```java
@Test
public void testDownloadAndValidate() throws IOException {
    Response response = given()
        .baseUri("https://httpbin.org")
    .when()
        .get("/image/png")
    .then()
        .statusCode(200)
        .header("Content-Type", "image/png")
        .extract()
        .response();
    
    // Get file bytes
    byte[] fileContent = response.asByteArray();
    
    // Validate file size
    Assert.assertTrue(fileContent.length > 0, "File should not be empty");
    
    // Save file
    Path filePath = Paths.get("target/test-download.png");
    Files.write(filePath, fileContent);
    
    // Validate file exists
    Assert.assertTrue(Files.exists(filePath), "Downloaded file should exist");
    
    // Validate file size on disk
    long fileSize = Files.size(filePath);
    Assert.assertTrue(fileSize > 0, "Downloaded file should have content");
}
```

---

### Chương 10: Serialization & Deserialization

#### 10.1 POJO Classes Setup

**User.java:**
```java
package models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class User {
    private Integer id;
    private String name;
    private String username;
    private String email;
    private String phone;
    private String website;
    private Address address;
    private Company company;
}
```

**Address.java:**
```java
package models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Address {
    private String street;
    private String suite;
    private String city;
    private String zipcode;
    private Geo geo;
}
```

**Geo.java:**
```java
package models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Geo {
    private String lat;
    private String lng;
}
```

**Company.java:**
```java
package models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Company {
    private String name;
    private String catchPhrase;
    private String bs;
}
```

#### 10.2 Serialization - Object to JSON

**Test với POJO:**
```java
@Test
public void testSerializationPOJO() {
    // Create User object
    User user = new User();
    user.setName("Nguyen Van A");
    user.setUsername("nguyenvana");
    user.setEmail("nguyenvana@example.com");
    user.setPhone("0901234567");
    user.setWebsite("nguyenvana.com");
    
    // Rest Assured automatically serializes POJO to JSON
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .body(user)  // Automatic serialization
        .log().body()
    .when()
        .post("/users")
    .then()
        .statusCode(201)
        .body("name", equalTo("Nguyen Van A"))
        .body("email", equalTo("nguyenvana@example.com"));
}
```

**Test với nested objects:**
```java
@Test
public void testSerializationNestedObjects() {
    // Create nested objects
    Geo geo = new Geo("-37.3159", "81.1496");
    
    Address address = new Address();
    address.setStreet("123 Main Street");
    address.setCity("Hanoi");
    address.setZipcode("100000");
    address.setGeo(geo);
    
    Company company = new Company();
    company.setName("ABC Company");
    company.setCatchPhrase("Innovative Solutions");
    
    User user = new User();
    user.setName("Tran Thi B");
    user.setEmail("tranthib@example.com");
    user.setAddress(address);
    user.setCompany(company);
    
    // Serialize and send
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .contentType(ContentType.JSON)
        .body(user)
        .log().body()
    .when()
        .post("/users")
    .then()
        .statusCode(201)
        .body("address.city", equalTo("Hanoi"))
        .body("company.name", equalTo("ABC Company"));
}
```

#### 10.3 Deserialization - JSON to Object

**Single Object:**
```java
@Test
public void testDeserializationSingleObject() {
    User user = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users/1")
    .then()
        .statusCode(200)
        .extract()
        .as(User.class);  // Automatic deserialization
    
    // Use the object
    System.out.println("=== User Information ===");
    System.out.println("ID: " + user.getId());
    System.out.println("Name: " + user.getName());
    System.out.println("Email: " + user.getEmail());
    System.out.println("City: " + user.getAddress().getCity());
    System.out.println("Company: " + user.getCompany().getName());
    
    // Assertions
    Assert.assertEquals(user.getId(), Integer.valueOf(1));
    Assert.assertEquals(user.getName(), "Leanne Graham");
    Assert.assertNotNull(user.getEmail());
    Assert.assertNotNull(user.getAddress());
}
```

**Array/List of Objects:**
```java
@Test
public void testDeserializationArray() {
    // Method 1: As Array
    User[] usersArray = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .statusCode(200)
        .extract()
        .as(User[].class);
    
    System.out.println("Total users: " + usersArray.length);
    
    // Method 2: As List
    List<User> usersList = Arrays.asList(usersArray);
    
    // Iterate and validate
    for (User user : usersList) {
        System.out.println(user.getName() + " - " + user.getEmail());
        Assert.assertNotNull(user.getId());
        Assert.assertNotNull(user.getName());
    }
    
    // Assertions
    Assert.assertEquals(usersArray.length, 10);
    Assert.assertTrue(usersList.stream()
        .allMatch(u -> u.getEmail().contains("@")));
}
```

**Using TypeRef for List:**
```java
@Test
public void testDeserializationList() {
    Response response = given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .statusCode(200)
        .extract()
        .response();
    
    // Convert to List<User>
    List<User> users = response.jsonPath()
        .getList("", User.class);
    
    System.out.println("Users count: " + users.size());
    
    users.forEach(user -> {
        System.out.println(user.getName());
    });
}
```

#### 10.4 Complete CRUD với POJO

```java
public class UserCRUDTest {
    private String baseUri = "https://jsonplaceholder.typicode.com";
    private User createdUser;
    
    @Test(priority = 1)
    public void testCreateUser() {
        // Prepare user object
        User newUser = new User();
        newUser.setName("Test User");
        newUser.setUsername("testuser");
        newUser.setEmail("test@example.com");
        newUser.setPhone("0909090909");
        
        // Create user
        createdUser = given()
            .baseUri(baseUri)
            .contentType(ContentType.JSON)
            .body(newUser)
        .when()
            .post("/users")
        .then()
            .statusCode(201)
            .extract()
            .as(User.class);
        
        // Validate
        Assert.assertNotNull(createdUser.getId());
        Assert.assertEquals(createdUser.getName(), "Test User");
        
        System.out.println("Created User ID: " + createdUser.getId());
    }
    
    @Test(priority = 2)
    public void testGetUser() {
        User user = given()
            .baseUri(baseUri)
            .pathParam("id", 1)
        .when()
            .get("/users/{id}")
        .then()
            .statusCode(200)
            .extract()
            .as(User.class);
        
        Assert.assertEquals(user.getId(), Integer.valueOf(1));
        Assert.assertNotNull(user.getName());
        
        System.out.println("Retrieved User: " + user.getName());
    }
    
    @Test(priority = 3)
    public void testUpdateUser() {
        User updateUser = new User();
        updateUser.setName("Updated Name");
        updateUser.setEmail("updated@example.com");
        
        User updatedUser = given()
            .baseUri(baseUri)
            .contentType(ContentType.JSON)
            .pathParam("id", 1)
            .body(updateUser)
        .when()
            .put("/users/{id}")
        .then()
            .statusCode(200)
            .extract()
            .as(User.class);
        
        Assert.assertEquals(updatedUser.getName(), "Updated Name");
        
        System.out.println("Updated User: " + updatedUser.getName());
    }
    
    @Test(priority = 4)
    public void testGetAllUsers() {
        User[] users = given()
            .baseUri(baseUri)
        .when()
            .get("/users")
        .then()
            .statusCode(200)
            .extract()
            .as(User[].class);
        
        Assert.assertEquals(users.length, 10);
        
        System.out.println("Total Users: " + users.length);
    }
}
```

#### 10.5 Custom Jackson Configuration

```java
// Custom ObjectMapper
ObjectMapper objectMapper = new ObjectMapper();
objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);

// Use with Rest Assured
RestAssured.config = RestAssuredConfig.config()
    .objectMapperConfig(new ObjectMapperConfig()
        .jackson2ObjectMapperFactory((type, s) -> objectMapper));
```

---

### Chương 11: Request/Response Specifications

#### 11.1 Request Specification

**Basic Request Spec:**
```java
public class APITest {
    private RequestSpecification requestSpec;
    
    @BeforeClass
    public void setup() {
        requestSpec = new RequestSpecBuilder()
            .setBaseUri("https://jsonplaceholder.typicode.com")
            .setContentType(ContentType.JSON)
            .addHeader("Accept", "application/json")
            .build();
    }
    
    @Test
    public void testWithRequestSpec() {
        given()
            .spec(requestSpec)
        .when()
            .get("/users")
        .then()
            .statusCode(200);
    }
}
```

**Advanced Request Spec:**
```java
@BeforeClass
public void setupAdvancedRequestSpec() {
    requestSpec = new RequestSpecBuilder()
        .setBaseUri("https://api.example.com")
        .setBasePath("/v1")
        .setContentType(ContentType.JSON)
        .addHeader("Accept", "application/json")
        .addHeader("User-Agent", "RestAssured-Test")
        .setRelaxedHTTPSValidation()
        .addFilter(new RequestLoggingFilter())
        .addFilter(new ResponseLoggingFilter())
        .setConfig(RestAssuredConfig.config()
            .httpClient(HttpClientConfig.httpClientConfig()
                .setParam(CoreConnectionPNames.CONNECTION_TIMEOUT, 5000)
                .setParam(CoreConnectionPNames.SO_TIMEOUT, 5000)))
        .build();
}
```

#### 11.2 Response Specification

**Basic Response Spec:**
```java
@BeforeClass
public void setupResponseSpec() {
    responseSpec = new ResponseSpecBuilder()
        .expectStatusCode(200)
        .expectContentType(ContentType.JSON)
        .expectResponseTime(lessThan(2000L))
        .build();
}

@Test
public void testWithResponseSpec() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .spec(responseSpec)
        .body("size()", equalTo(10));
}
```

**Multiple Response Specs:**
```java
public class Specifications {
    
    public static ResponseSpecification responseSpec200() {
        return new ResponseSpecBuilder()
            .expectStatusCode(200)
            .expectContentType(ContentType.JSON)
            .expectResponseTime(lessThan(3000L))
            .build();
    }
    
    public static ResponseSpecification responseSpec201() {
        return new ResponseSpecBuilder()
            .expectStatusCode(201)
            .expectContentType(ContentType.JSON)
            .expectHeader("Location", notNullValue())
            .build();
    }
    
    public static ResponseSpecification responseSpec400() {
        return new ResponseSpecBuilder()
            .expectStatusCode(400)
            .expectBody("error", notNullValue())
            .build();
    }
}

// Usage
@Test
public void testGetUsers() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
    .when()
        .get("/users")
    .then()
        .spec(Specifications.responseSpec200());
}

@Test
public void testCreateUser() {
    given()
        .baseUri("https://jsonplaceholder.typicode.com")
        .body(new User())
    .when()
        .post("/users")
    .then()
        .spec(Specifications.responseSpec201());
}
```

#### 11.3 Reusable Specifications Class

```java
package specifications;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.builder.ResponseSpecBuilder;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;

import static org.hamcrest.Matchers.*;

public class Specifications {
    
    // Base Request Spec
    public static RequestSpecification requestSpec(String baseUri) {
        return new RequestSpecBuilder()
            .setBaseUri(baseUri)
            .setContentType(ContentType.JSON)
            .addHeader("Accept", "application/json")
            .addFilter(new RequestLoggingFilter())
            .addFilter(new ResponseLoggingFilter())
            .build();
    }
    
    // Request Spec với Authentication
    public static RequestSpecification requestSpecWithAuth(String baseUri, String token) {
        return new RequestSpecBuilder()
            .setBaseUri(baseUri)
            .setContentType(ContentType.JSON)
            .addHeader("Authorization", "Bearer " + token)
            .addFilter(new RequestLoggingFilter())
            .addFilter(new ResponseLoggingFilter())
            .build();
    }
    
    // Response Spec 200 OK
    public static ResponseSpecification responseSpec200() {
        return new ResponseSpecBuilder()
            .expectStatusCode(200)
            .expectContentType(ContentType.JSON)
            .build();
    }
    
    // Response Spec 201 Created
    public static ResponseSpecification responseSpec201() {
        return new ResponseSpecBuilder()
            .expectStatusCode(201)
            .expectContentType(ContentType.JSON)
            .build();
    }
    
    // Response Spec 204 No Content
    public static ResponseSpecification responseSpec204() {
        return new ResponseSpecBuilder()
            .expectStatusCode(204)
            .build();
    }
    
    // Response Spec 400 Bad Request
    public static ResponseSpecification responseSpec400() {
        return new ResponseSpecBuilder()
            .expectStatusCode(400)
            .expectContentType(ContentType.JSON)
            .build();
    }
    
    // Response Spec 401 Unauthorized
    public static ResponseSpecification responseSpec401() {
        return new ResponseSpecBuilder()
            .expectStatusCode(401)
            .build();
    }
    
    // Response Spec 404 Not Found
    public static ResponseSpecification responseSpec404() {
        return new ResponseSpecBuilder()
            .expectStatusCode(404)
            .build();
    }
    
    // Custom Response Spec với validation
    public static ResponseSpecification responseSpecWithValidation() {
        return new ResponseSpecBuilder()
            .expectStatusCode(200)
            .expectContentType(ContentType.JSON)
            .expectResponseTime(lessThan(3000L))
            .expectBody("size()", greaterThan(0))
            .build();
    }
}
```

**Usage in Tests:**
```java
package tests;

import specifications.Specifications;
import org.testng.annotations.Test;
import static io.restassured.RestAssured.given;

public class UserTestsWithSpec {
    
    private String baseUri = "https://jsonplaceholder.typicode.com";
    
    @Test
    public void testGetAllUsers() {
        given()
            .spec(Specifications.requestSpec(baseUri))
        .when()
            .get("/users")
        .then()
            .spec(Specifications.responseSpec200());
    }
    
    @Test
    public void testCreateUser() {
        String requestBody = """
            {
                "name": "Test User",
                "email": "test@example.com"
            }
            """;
        
        given()
            .spec(Specifications.requestSpec(baseUri))
            .body(requestBody)
        .when()
            .post("/users")
        .then()
            .spec(Specifications.responseSpec201());
    }
    
    @Test
    public void testGetUserNotFound() {
        given()
            .spec(Specifications.requestSpec(baseUri))
        .when()
            .get("/users/9999")
        .then()
            .spec(Specifications.responseSpec404());
    }
}
```

#### 11.4 Global Specifications

```java
public class BaseTest {
    
    @BeforeClass
    public void globalSetup() {
        // Set global request spec
        RestAssured.requestSpecification = new RequestSpecBuilder()
            .setBaseUri("https://jsonplaceholder.typicode.com")
            .setContentType(ContentType.JSON)
            .build();
        
        // Set global response spec
        RestAssured.responseSpecification = new ResponseSpecBuilder()
            .expectContentType(ContentType.JSON)
            .build();
    }
    
    @AfterClass
    public void globalTeardown() {
        // Reset specifications
        RestAssured.reset();
    }
}

// All tests inherit global specs
public class UserTests extends BaseTest {
    
    @Test
    public void testGetUsers() {
        // Automatically uses global specs
        when()
            .get("/users")
        .then()
            .statusCode(200);
    }
}
```

---

## PHẦN 4: FRAMEWORK DESIGN

### Chương 12: Page Object Pattern cho API

#### 12.1 Endpoint Classes Structure

```
src/main/java/
└── endpoints/
    ├── UserEndpoints.java
    ├── PostEndpoints.java
    └── CommentEndpoints.java
```

#### 12.2 User Endpoints Class

```java
package endpoints;

import io.restassured.response.Response;
import models.User;
import specifications.Specifications;

import static io.restassured.RestAssured.given;

public class UserEndpoints {
    private static final String BASE_URI = "https://jsonplaceholder.typicode.com";
    private static final String BASE_PATH = "/users";
    
    // GET all users
    public static Response getAllUsers() {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
        .when()
            .get(BASE_PATH)
        .then()
            .spec(Specifications.responseSpec200())
            .extract()
            .response();
    }
    
    // GET user by ID
    public static Response getUserById(int userId) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", userId)
        .when()
            .get(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
    
    // POST - Create user
    public static Response createUser(User user) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .body(user)
        .when()
            .post(BASE_PATH)
        .then()
            .spec(Specifications.responseSpec201())
            .extract()
            .response();
    }
    
    // PUT - Update user
    public static Response updateUser(int userId, User user) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", userId)
            .body(user)
        .when()
            .put(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
    
    // PATCH - Partial update
    public static Response partialUpdateUser(int userId, User user) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", userId)
            .body(user)
        .when()
            .patch(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
    
    // DELETE user
    public static Response deleteUser(int userId) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", userId)
        .when()
            .delete(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
    
    // GET users with query params
    public static Response getUsersByEmail(String email) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .queryParam("email", email)
        .when()
            .get(BASE_PATH)
        .then()
            .extract()
            .response();
    }
}
```

#### 12.3 Post Endpoints Class

```java
package endpoints;

import io.restassured.response.Response;
import models.Post;
import specifications.Specifications;

import static io.restassured.RestAssured.given;

public class PostEndpoints {
    private static final String BASE_URI = "https://jsonplaceholder.typicode.com";
    private static final String BASE_PATH = "/posts";
    
    public static Response getAllPosts() {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
        .when()
            .get(BASE_PATH)
        .then()
            .spec(Specifications.responseSpec200())
            .extract()
            .response();
    }
    
    public static Response getPostById(int postId) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", postId)
        .when()
            .get(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
    
    public static Response getPostsByUserId(int userId) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .queryParam("userId", userId)
        .when()
            .get(BASE_PATH)
        .then()
            .extract()
            .response();
    }
    
    public static Response createPost(Post post) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .body(post)
        .when()
            .post(BASE_PATH)
        .then()
            .spec(Specifications.responseSpec201())
            .extract()
            .response();
    }
    
    public static Response updatePost(int postId, Post post) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", postId)
            .body(post)
        .when()
            .put(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
    
    public static Response deletePost(int postId) {
        return given()
            .spec(Specifications.requestSpec(BASE_URI))
            .pathParam("id", postId)
        .when()
            .delete(BASE_PATH + "/{id}")
        .then()
            .extract()
            .response();
    }
}
```

#### 12.4 Using Endpoint Classes in Tests

```java
package tests;

import endpoints.UserEndpoints;
import endpoints.PostEndpoints;
import io.restassured.response.Response;
import models.User;
import models.Post;
import org.testng.Assert;
import org.testng.annotations.Test;

import static org.hamcrest.Matchers.*;

public class APITests {
    
    @Test
    public void testGetAllUsers() {
        Response response = UserEndpoints.getAllUsers();
        
        response.then()
            .statusCode(200)
            .body("size()", equalTo(10));
        
        // Extract and validate
        User[] users = response.as(User[].class);
        Assert.assertEquals(users.length, 10);
    }
    
    @Test
    public void testCreateUser() {
        User newUser = new User();
        newUser.setName("Test User");
        newUser.setEmail("test@example.com");
        
        Response response = UserEndpoints.createUser(newUser);
        
        response.then()
            .statusCode(201)
            .body("name", equalTo("Test User"));
        
        User createdUser = response.as(User.class);
        Assert.assertNotNull(createdUser.getId());
    }
    
    @Test
    public void testGetPostsByUser() {
        int userId = 1;
        
        Response response = PostEndpoints.getPostsByUserId(userId);
        
        response.then()
            .statusCode(200)
            .body("userId", everyItem(equalTo(userId)));
        
        Post[] posts = response.as(Post[].class);
        Assert.assertTrue(posts.length > 0);
    }
    
    @Test
    public void testCompleteUserFlow() {
        // Step 1: Create user
        User newUser = new User();
        newUser.setName("Flow Test User");
        newUser.setEmail("flowtest@example.com");
        
        Response createResponse = UserEndpoints.createUser(newUser);
        User createdUser = createResponse.as(User.class);
        int userId = createdUser.getId();
        
        // Step 2: Get user
        Response getResponse = UserEndpoints.getUserById(userId);
        getResponse.then().statusCode(200);
        
        // Step 3: Update user
        createdUser.setName("Updated Name");
        Response updateResponse = UserEndpoints.updateUser(userId, createdUser);
        updateResponse.then().statusCode(200);
        
        // Step 4: Delete user
        Response deleteResponse = UserEndpoints.deleteUser(userId);
        deleteResponse.then().statusCode(200);
    }
}
```

---

### Chương 13: Data-Driven Testing

#### 13.1 Using TestNG DataProvider

**Simple DataProvider:**
```java
package tests;

import endpoints.UserEndpoints;
import io.restassured.response.Response;
import models.User;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class DataDrivenTest {
    
    @DataProvider(name = "userData")
    public Object[][] getUserData() {
        return new Object[][] {
            {"User1", "user1@example.com", "0901111111"},
            {"User2", "user2@example.com", "0902222222"},
            {"User3", "user3@example.com", "0903333333"}
        };
    }
    
    @Test(dataProvider = "userData")
    public void testCreateMultipleUsers(String name, String email, String phone) {
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        
        Response response = UserEndpoints.createUser(user);
        
        response.then()
            .statusCode(201)
            .body("name", equalTo(name))
            .body("email", equalTo(email));
        
        System.out.println("Created user: " + name);
    }
}
```

#### 13.2 DataProvider từ Excel

**Thêm dependency:**
```xml
<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi-ooxml</artifactId>
    <version>5.2.3</version>
</dependency>
```

**ExcelUtils.java:**
```java
package utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ExcelUtils {
    
    public static Object[][] getTestData(String filePath, String sheetName) {
        List<Object[]> data = new ArrayList<>();
        
        try (FileInputStream fis = new FileInputStream(filePath);
             Workbook workbook = new XSSFWorkbook(fis)) {
            
            Sheet sheet = workbook.getSheet(sheetName);
            int rowCount = sheet.getLastRowNum();
            int colCount = sheet.getRow(0).getLastCellNum();
            
            for (int i = 1; i <= rowCount; i++) {
                Row row = sheet.getRow(i);
                Object[] rowData = new Object[colCount];
                
                for (int j = 0; j < colCount; j++) {
                    Cell cell = row.getCell(j);
                    rowData[j] = getCellValue(cell);
                }
                data.add(rowData);
            }
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return data.toArray(new Object[0][]);
    }
    
    private static Object getCellValue(Cell cell) {
        if (cell == null) return "";
        
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                return (int) cell.getNumericCellValue();
            case BOOLEAN:
                return cell.getBooleanCellValue();
            default:
                return "";
        }
    }
}
```

**Test với Excel data:**
```java
@DataProvider(name = "excelData")
public Object[][] getDataFromExcel() {
    String filePath = "src/test/resources/testdata/users.xlsx";
    return ExcelUtils.getTestData(filePath, "UserData");
}

@Test(dataProvider = "excelData")
public void testWithExcelData(String name, String email, String phone) {
    User user = new User();
    user.setName(name);
    user.setEmail(email);
    user.setPhone(phone);
    
    Response response = UserEndpoints.createUser(user);
    response.then().statusCode(201);
}
```

#### 13.3 DataProvider từ JSON

**users.json:**
```json
[
  {
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "0901234567"
  },
  {
    "name": "Jane Smith",
    "email": "jane@example.com",
    "phone": "0907654321"
  }
]
```

**JSONUtils.java:**
```java
package utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import models.User;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class JSONUtils {
    
    public static List<User> getUsersFromJSON(String filePath) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            User[] users = mapper.readValue(new File(filePath), User[].class);
            return Arrays.asList(users);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
```

**Test với JSON data:**
```java
@DataProvider(name = "jsonData")
public Object[][] getDataFromJSON() {
    List<User> users = JSONUtils.getUsersFromJSON(
        "src/test/resources/testdata/users.json");
    
    Object[][] data = new Object[users.size()][1];
    for (int i = 0; i < users.size(); i++) {
        data[i][0] = users.get(i);
    }
    return data;
}

@Test(dataProvider = "jsonData")
public void testWithJSONData(User user) {
    Response response = UserEndpoints.createUser(user);
    response.then().statusCode(201);
}
```

#### 13.4 DataProvider Factory

```java
package dataproviders;

import utils.ExcelUtils;
import utils.JSONUtils;
import models.User;

public class DataProviderFactory {
    
    public static Object[][] getUserDataFromExcel() {
        return ExcelUtils.getTestData(
            "src/test/resources/testdata/users.xlsx",
            "Users"
        );
    }
    
    public static Object[][] getUserDataFromJSON() {
        List<User> users = JSONUtils.getUsersFromJSON(
            "src/test/resources/testdata/users.json");
        
        Object[][] data = new Object[users.size()][1];
        for (int i = 0; i < users.size(); i++) {
            data[i][0] = users.get(i);
        }
        return data;
    }
    
    public static Object[][] getInvalidUserData() {
        return new Object[][] {
            {"", "invalid@email", "phone"},
            {"Name", "", "phone"},
            {"Name", "email", ""},
            {null, "email", "phone"}
        };
    }
}
```

---

### Chương 14: Reporting & Logging

#### 14.1 Extent Reports Setup

**ExtentManager.java:**
```java
package reports;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;

public class ExtentManager {
    private static ExtentReports extent;
    private static ThreadLocal<ExtentTest> test = new ThreadLocal<>();
    
    public static ExtentReports createInstance(String fileName) {
        ExtentSparkReporter htmlReporter = new ExtentSparkReporter(fileName);
        
        htmlReporter.config().setTheme(Theme.DARK);
        htmlReporter.config().setDocumentTitle("API Automation Report");
        htmlReporter.config().setEncoding("utf-8");
        htmlReporter.config().setReportName("REST Assured Test Results");
        
        extent = new ExtentReports();
        extent.attachReporter(htmlReporter);
        extent.setSystemInfo("Automation Tester", "Your Name");
        extent.setSystemInfo("Organization", "Your Company");
        extent.setSystemInfo("Build", "1.0");
        
        return extent;
    }
    
    public static ExtentReports getInstance() {
        if (extent == null) {
            createInstance("test-output/ExtentReport.html");
        }
        return extent;
    }
    
    public static void setTest(ExtentTest extentTest) {
        test.set(extentTest);
    }
    
    public static ExtentTest getTest() {
        return test.get();
    }
}
```

**ExtentReportListener.java:**
```java
package listeners;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;
import org.testng.*;
import reports.ExtentManager;

public class ExtentReportListener implements ITestListener {
    private static ExtentReports extent = ExtentManager.getInstance();
    
    @Override
    public void onStart(ITestContext context) {
        System.out.println("Test Suite started: " + context.getName());
    }
    
    @Override
    public void onFinish(ITestContext context) {
        extent.flush();
        System.out.println("Test Suite finished: " + context.getName());
    }
    
    @Override
    public void onTestStart(ITestResult result) {
        ExtentTest test = extent.createTest(result.getMethod().getMethodName());
        ExtentManager.setTest(test);
    }
    
    @Override
    public void onTestSuccess(ITestResult result) {
        ExtentManager.getTest().log(Status.PASS, "Test passed");
    }
    
    @Override
    public void onTestFailure(ITestResult result) {
        ExtentManager.getTest().log(Status.FAIL, "Test failed");
        ExtentManager.getTest().fail(result.getThrowable());
    }
    
    @Override
    public void onTestSkipped(ITestResult result) {
        ExtentManager.getTest().log(Status.SKIP, "Test skipped");
    }
}
```

**Usage in Tests:**
```java
@Listeners(ExtentReportListener.class)
public class UserTests {
    
    @Test
    public void testGetAllUsers() {
        ExtentManager.getTest().info("Starting test: Get all users");
        
        Response response = UserEndpoints.getAllUsers();
        
        ExtentManager.getTest().info("Response received with status: " + 
            response.getStatusCode());
        
        response.then().statusCode(200);
        
        ExtentManager.getTest().pass("Test completed successfully");
    }
}
```

#### 14.2 Allure Reports

**Cấu hình pom.xml đã có ở Chương 2**

**Usage trong tests:**
```java
import io.qameta.allure.*;

@Epic("User Management")
@Feature("User API")
public class UserTests {
    
    @Test
    @Story("Get User")
    @Description("Test to get user by ID")
    @Severity(SeverityLevel.CRITICAL)
    public void testGetUserById() {
        int userId = 1;
        
        Allure.step("Send GET request to /users/" + userId);
        Response response = UserEndpoints.getUserById(userId);
        
        Allure.step("Validate response status code is 200");
        response.then().statusCode(200);
        
        Allure.step("Validate response body");
        response.then()
            .body("id", equalTo(userId))
            .body("name", notNullValue());
        
        // Attach response
        Allure.addAttachment("Response", response.asString());
    }
    
    @Test
    @Story("Create User")
    @Description("Test to create a new user")
    @Severity(SeverityLevel.BLOCKER)
    public void testCreateUser() {
        User user = new User();
        user.setName("Test User");
        user.setEmail("test@example.com");
        
        Allure.step("Prepare request body", () -> {
            Allure.addAttachment("Request", user.toString());
        });
        
        Allure.step("Send POST request");
        Response response = UserEndpoints.createUser(user);
        
        Allure.step("Validate creation");
        response.then().statusCode(201);
        
        Allure.addAttachment("Response", response.asString());
    }
}
```

**Generate Allure Report:**
```bash
# Run tests
mvn clean test

# Generate report
mvn allure:report

# Serve report
mvn allure:serve
```

#### 14.3 Custom Logging

**LogUtils.java:**
```java
package utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class LogUtils {
    private static Logger logger = LogManager.getLogger(LogUtils.class);
    
    public static void info(String message) {
        logger.info(message);
    }
    
    public static void error(String message) {
        logger.error(message);
    }
    
    public static void debug(String message) {
        logger.debug(message);
    }
    
    public static void warn(String message) {
        logger.warn(message);
    }
}
```

**log4j2.xml:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
        
        <File name="File" fileName="logs/automation.log">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </File>
    </Appenders>
    
    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="File"/>
        </Root>
    </Loggers>
</Configuration>
```

---

### Chương 15: CI/CD Integration

#### 15.1 Maven Commands

```bash
# Clean and compile
mvn clean compile

# Run all tests
mvn clean test

# Run specific test class
mvn test -Dtest=UserTests

# Run specific test method
mvn test -Dtest=UserTests#testGetAllUsers

# Run với suite
mvn test -DsuiteXmlFile=testng.xml

# Parallel execution
mvn test -DthreadCount=3 -Dparallel=methods

# Skip tests
mvn clean install -DskipTests
```

#### 15.2 GitHub Actions Workflow

**.github/workflows/api-tests.yml:**
```yaml
name: API Automation Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * *'  # Run daily at midnight

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    
    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        distribution: 'adopt'
    
    - name: Cache Maven packages
      uses: actions/cache@v3
      with:
        path: ~/.m2
        key: ${{ runner.os }}-m2-${{ hashFiles('**/pom.xml') }}
        restore-keys: ${{ runner.os }}-m2
    
    - name: Run tests
      run: mvn clean test
    
    - name: Generate Allure Report
      if: always()
      run: mvn allure:report
    
    - name: Upload test results
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: test-results
        path: target/surefire-reports/
    
    - name: Upload Allure Report
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: allure-report
        path: target/allure-results/
```

#### 15.3 Jenkins Pipeline

**Jenkinsfile:**
```groovy
pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8.1'
        jdk 'JDK-11'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/your-repo/api-automation.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Generate Reports') {
            steps {
                sh 'mvn allure:report'
            }
        }
    }
    
    post {
        always {
            junit '**/target/surefire-reports/*.xml'
            
            allure includeProperties: false,
                   jdk: '',
                   results: [[path: 'target/allure-results']]
        }
        
        success {
            echo 'Tests passed successfully!'
        }
        
        failure {
            echo 'Tests failed!'
        }
    }
}
```

---

## BÀI TẬP THỰC HÀNH

### Bài tập 1: Basic CRUD (Cơ bản)

**Yêu cầu:**
Sử dụng API https://jsonplaceholder.typicode.com

1. Viết test GET tất cả users và validate:
   - Status code 200
   - Response có 10 users
   - Mỗi user có đầy đủ: id, name, email

2. Viết test GET user theo ID và validate:
   - Status code 200
   - User ID đúng
   - Address không null

3. Viết test POST tạo user mới và validate:
   - Status code 201
   - Response trả về user với ID

4. Viết test PUT update user và validate:
   - Status code 200
   - Dữ liệu đã được cập nhật

5. Viết test DELETE user và validate:
   - Status code 200

### Bài tập 2: Advanced Validation (Trung bình)

1. Validate JSON Schema cho response
2. Validate nested objects (address, company)
3. Validate arrays với filter conditions
4. Extract values và so sánh
5. Validate response time < 2 seconds

### Bài tập 3: Framework Design (Nâng cao)

**Yêu cầu:**
Xây dựng framework hoàn chỉnh với:

1. **Structure:**
   - Endpoint classes cho User, Post, Comment
   - POJO models
   - Specifications class
   - Utils classes

2. **Features:**
   - Request/Response specifications
   - Serialization/Deserialization
   - Data-driven testing
   - Extent Reports
   - Logging

3. **Tests:**
   - Viết ít nhất 15 test cases
   - Sử dụng DataProvider
   - Parallel execution
   - Generate reports

### Bài tập 4: Real API Testing (Thực tế)

**Chọn một trong các API sau:**
- ReqRes API: https://reqres.in
- GoRest API: https://gorest.co.in
- Swagger Petstore: https://petstore.swagger.io

**Yêu cầu:**
1. Đọc API documentation
2. Xây dựng complete test suite
3. Implement authentication nếu có
4. Data-driven testing
5. Complete reporting
6. CI/CD integration

---

## KẾT LUẬN

### Tóm tắt kiến thức

Bạn đã học được:

✅ **Cơ bản:**
- Rest Assured setup
- Given-When-Then pattern
- HTTP methods
- Request/Response validation

✅ **Nâng cao:**
- Authentication & Authorization
- File handling
- Serialization/Deserialization
- Specifications

✅ **Framework:**
- Endpoint pattern
- Data-driven testing
- Reporting
- CI/CD integration

### Best Practices

1. **Code Organization:**
   - Sử dụng Page Object Pattern
   - Tách biệt test data
   - Reusable specifications

2. **Assertions:**
   - Validate đầy đủ: status, headers, body
   - Sử dụng Hamcrest matchers
   - Extract và verify POJO

3. **Maintenance:**
   - DRY principle
   - Meaningful test names
   - Good logging và reporting

4. **Performance:**
   - Parallel execution
   - Connection pooling
   - Timeout configuration

### Next Steps

1. **Practice:** Thực hành với real APIs
2. **Advanced Topics:**
   - GraphQL testing
   - WebSocket testing
   - Performance testing
3. **Integration:**
   - Database validation
   - Message Queue testing
4. **Tools:**
   - Postman to Rest Assured converter
   - API monitoring tools

**Chúc bạn thành công với API Automation Testing! 🚀**
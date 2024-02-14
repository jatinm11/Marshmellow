# Marshmellow
A simple networking SDK for DevRev assignment.

**Marshmellow is a very basic library that is built on top of apple's URLSession()**<br>
**The main building blocks of this sdk are following 2 classes:-**

<details>
<summary>public class MellowRequestBuilder (Expand)</summary>
  <br>
This class is responsible for building URL requests based on provided parameters.
  <br><br>
Key parameters include:
  <br>
  <br><b> - init: Initializes a request builder with base URL, path, and optional parameters.</b>
  <br> - Methods to set various request attributes such as method, path, scheme, headers, and parameters. 
  <br> - buildRequest(): Constructs a URL request based on the provided parameters and returns it along with any potential errors.
  <br><br>

  
  ``` swift
          let builder = MellowRequestBuilder(
            baseURL: URL(string: urlString),
            path: requestEndpoint,
            method: method,
            scheme: scheme,
            headers: headers
        )
  ```
</details>

<details>
<summary>public class Marshmellow (Expand)</summary>
  <br>
This class conforms to the MellowNetworkProtocol protocol and provides implementation for making network requests. It includes methods to set the key decoding strategy and make requests using the provided builder. 
  <br><br>

  
  ``` swift
          Marshmellow().makeRequest(with: builder, type: T.self, completion: completion)
  ```
</details>

Combining the above 2 classes we get :-
``` swift
let marshmellow = Marshmellow()
let builder = MellowRequestBuilder(baseURL: baseURL, path: "/api/resource")
    .set(method: .get)
    .set(headers: ["Authorization": "Bearer token"])

marshmellow.makeRequest(with: builder, type: MyResponse.self) { result in
    switch result {
    case .success(let response):
        // Handle successful response
    case .failure(let error):
        // Handle error
    }
}
```

That's it! 🥂 <br><br>
P.S - **This was only built for the assignment purpose and in no way is a complete library and has huge scope of improvements** 😬 <br><br> 
P.P.S - **I hope you love eating Marshmellows** 😉

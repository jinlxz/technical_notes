okhttp practices
---------
### 1. use okhttp to send sorts of requests.
- instantiate a `OkHttpClient` object which provides methods to execute a request.
- A builder object provides various methods to construct a real `Request` object
  - `HttpUrl.Builder` for http get request.
  - `MultipartBody.Builder` for multipart/form request.
  - `FormBody.Builder` for urlencoded form post request.
  - `Request.Builder` a basic builder, all other type of builder object will be passed to the method of this builder to construct the final request object. 
- A `Request` object to save a *request* built by the builder and passed to the method `newCall()` of `OkHttpClient`
```java
  httpResponse = client.newCall(this.httpRequest).execute();
```
- A `Response` object to save the response, which provides access to headers and body.
```
  if(this.httpResponse.header("Content-Type")!=null && \
  this.httpResponse.header("Content-Type").startsWith("multipart/form-data"))
    this.responseBytes=this.httpResponse.body().bytes();
  else
    this.responseString=this.httpResponse.body().string();
  this.httpResponse.close(); // must be closed after the function body() is called. 
```
A full demo codes are as follows:
```java
  this.client=new OkHttpClient.Builder()
            .connectTimeout(2000, TimeUnit.MILLISECONDS)
            .writeTimeout(2000, TimeUnit.MILLISECONDS)
            .readTimeout(2000, TimeUnit.MILLISECONDS)
            .build();
  MultipartBody.Builder multipartBuilder=new MultipartBody.Builder().setType(MultipartBody.FORM);              
  RequestBody bodypart=RequestBody.create(okhttp3.MediaType.get(content_type.replace("Content-Type:", "")), value);    
  Headers.Builder headerBuilder=new Headers.Builder();      
  headerBuilder.add(header);
  multipartBuilder.addPart(headerBuilder.build(), bodypart);
   
  MultipartBody tempbody=multipartBuilder.build();
  this.httpRequest=requestBuilder
      .header("Content-Type", "multipart/form-data; boundary=\""+  tempbody.boundary()+"\"")
      .header("Content-Length", String.valueOf(tempbody.contentLength()))
      .url(this.baseUrl+endpoint).post(tempbody).build();
      
  httpResponse = client.newCall(this.httpRequest).execute();
  if(this.httpResponse.header("Content-Type")!=null && this.httpResponse.header("Content-Type").startsWith("multipart/form-data"))
      this.responseBytes=this.httpResponse.body().bytes();
  else
      this.responseString=this.httpResponse.body().string();
  this.httpResponse.close();      
```
### 2. construct GET request with query parameters
use `HttpUrl.Builder` to construct the request, common methods are as follows:
 ```java
  // for adding part in URL
  public Builder addPathSegment(String pathSegment)
  // for adding query parameters
  public Builder addQueryParameter(String name, @Nullable String value)
```
examples:
```java
  URL baseUrl=new URL(this.baseUrl);
  String defaultPort=baseUrl.getProtocol().equals("http")?"80":"443";
  this.getUrlBuilder.scheme(baseUrl.getProtocol())
    .host(baseUrl.getHost())
    .port(baseUrl.getPort()==-1?Integer.valueOf(defaultPort):baseUrl.getPort());
  this.getUrlBuilder.addQueryParameter(queryPair[0], value);        
  this.getUrlBuilder.addPathSegment(endpoint);
  HttpUrl getUrl=this.getUrlBuilder.build();
  this.httpRequest=requestBuilder.url(getUrl).get().build();
```
### 3. construct POST request with urlencoded form data.
use `FormBody.Builder` object to build the form body.
```
  FormBody.Builder formBodyBuilder=new FormBody.Builder();
  formBodyBuilder.add(formParam[0],value);
  FormBody formbody=this.formBodyBuilder.build();
  this.httpRequest=requestBuilder.header("Content-Type", "application/x-www-form-urlencoded")
          .header("Content-Length", String.valueOf(formbody.contentLength())).url(this.baseUrl+endpoint)
          .post(formbody).build();
  httpResponse = client.newCall(this.httpRequest).execute();        
```
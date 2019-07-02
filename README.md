# Deploy Go on AWS Lambda

It is quite simple to deploy the go function on the AWS Lambda using [Aws Lambda Go](https://github.com/aws/aws-lambda-go). I'll demonstrate the lambda function using a simple request as input for lambda and return Ok response for this example.

## Steps

1. Get the aws lambda tool using. 
    ```bash
       go get -u github.com/aws/aws-lambda-go/cmd/build-lambda-zip
    ```
    
2. Create your lambda function.

    ```go
    // main.go
    package main
    
    import (
    	"fmt"
    
    	"github.com/aws/aws-lambda-go/lambda"
    )
    
    type Request struct {
    	ID    float64 `json:"id"`
    	Value string  `json:"value"`
    }
    
    type Response struct {
    	Message string `json:"message"`
    	Ok      bool   `json:"ok"`
    }
    
    func Handler(request Request) (Response, error) {
    	return Response{
    		Message: fmt.Sprintf("Process Request ID %f", request.ID),
    		Ok:      true,
    	}, nil
    }
    
    func main() {
    	// Make the handler available for Remote Procedure Call by AWS Lambda
    	lambda.Start(Handler)
    }
    ```

3. Build your lambda function for linux

    ```bash
    GOOS=linux go build -o main
    ```

    

4. Set required permission for execution

    ```bash
    sudo chmod +x main
    ```

5. Zip the build

    ```bash
    zip -9 main.zip main
    ```

6. Upload to lambda and test using the following event argument.

    ```json
    {
    	"id": 123,
    	"value": "This is a test value"
    }
    ```

    It gives us the following response.

    ```
    {
      "message": "Process Request ID 123.000000",
      "ok": true
    }
    ```

## Further Reading

- [What is AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Working with AWS Lambda Functions](https://docs.aws.amazon.com/lambda/latest/dg/lambda-introduction-function.html)
- [AWS Lambda Programming Model](https://docs.aws.amazon.com/lambda/latest/dg/programming-model-v2.html)
- [AWS Lambda Applications](https://docs.aws.amazon.com/lambda/latest/dg/deploying-lambda-apps.html)
- [AWS Lambda Go Repository](https://github.com/aws/aws-lambda-go)
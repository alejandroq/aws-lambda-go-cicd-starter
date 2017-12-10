package main

import (
	"github.com/eawsy/aws-lambda-go-core/service/lambda/runtime"
	"github.com/eawsy/aws-lambda-go-event/service/lambda/runtime/event/apigatewayproxyevt"
)

/** this main.main function exists primarily for go test ./... purposes. */
func main() {
	placeholderContext := runtime.Context{}
	placeholderEvt := apigatewayproxyevt.Event{}
	Handle(&placeholderEvt, &placeholderContext)
}

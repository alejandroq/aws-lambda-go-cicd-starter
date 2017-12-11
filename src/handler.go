package main

import (
	"log"

	"github.com/eawsy/aws-lambda-go-core/service/lambda/runtime"
	"github.com/eawsy/aws-lambda-go-event/service/lambda/runtime/event/apigatewayproxyevt"
)

// Handle is the primary Lambda handling function.
func Handle(evt *apigatewayproxyevt.Event, ctx *runtime.Context) (interface{}, error) {
	log.Println(evt)
	return "Hello World", nil
}

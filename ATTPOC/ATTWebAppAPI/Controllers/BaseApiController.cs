using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web.Http;

namespace ATTWebAppAPI.Controllers
{
    public class BaseApiController : ApiController
    {
        protected HttpResponseMessage WrapObjectToHttpResponse<T>(T responseData)
        {
            IContentNegotiator negotiator = this.Configuration.Services.GetContentNegotiator();
            ContentNegotiationResult result = negotiator.Negotiate(typeof(T), this.Request, this.Configuration.Formatters);
            return new HttpResponseMessage()
            {
                Content = new ObjectContent(typeof(T),
                    responseData, // What we are serializing
                    result.Formatter, // The media formatter
                    result.MediaType.MediaType), // The MIME type
                StatusCode = HttpStatusCode.OK,
                RequestMessage = this.Request
            };
        }
    }
}

using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;

namespace Pixel_Vision_API
{
    public class ValidationFilter : IActionFilter
    {
        public void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.ModelState.IsValid)
            {
                var errors = context.ModelState
                    .Where(x => x.Value!.Errors.Any())
                    .ToDictionary(
                        x => x.Key,
                        x => x.Value!.Errors.Select(e => e.ErrorMessage)
                    );

                context.Result = new BadRequestObjectResult(new
                {
                    message = "Validation failed",
                    errors
                });
            }
        }

        public void OnActionExecuted(ActionExecutedContext context) { }
    }

}

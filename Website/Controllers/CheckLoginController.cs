using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Website.Models;

namespace Website.Controllers
{
    public class CheckLoginController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var sess = (UserLoginModel)Session["USER_LOGIN"];
            if (sess == null)
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Login", action = "Index", Area = "" }));
            }
            base.OnActionExecuting(filterContext);
        }
    }
}
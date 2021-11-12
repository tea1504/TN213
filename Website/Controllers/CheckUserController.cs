using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Website.Models;

namespace Website.Controllers
{
    public class CheckUserController : Controller
    {
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            var sess = (UserLoginModel)Session["USER_LOGIN"];
            if (sess.ma_vt != 2)
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Home", action = "Index", Area = "" }));
            }
            base.OnActionExecuted(filterContext);
        }
    }
}
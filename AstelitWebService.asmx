<%@ WebService Language="C#" Class="Astelit.SOAPApp.Web.AstelitWebService" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;

namespace Astelit.SOAPApp.Web
{
    /// <summary>
    /// Summary description for AstelitWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AstelitWebService : System.Web.Services.WebService
    {
        [WebMethod(Description = "Вернуть JSON-приветствие для всего мира")]
          public string HelloWorld()
        {
            var data = new { Greeting = "Hello World" };
            System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
            return js.Serialize(data);
        }

        [WebMethod(Description = "Вернуть JSON-приветствие для конкретного человека")]
        public string HelloWorldForPerson(string firstName, string lastName)
        {
            var data = new { Greeting = "Hello", Name = firstName + " " + lastName };
            System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
            return js.Serialize(data);
        }

        [WebMethod(Description = "Вернуть JSON-приветствие для покупателя")]
        public string HelloWorldForCustomer(string customerName)
        {
            var data = new { Greeting = "Hello", Name = customerName };
            System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
            return js.Serialize(data);
        }

        [WebMethod(Description = "Вернуть JSON-результат сложения двух чисел")]
        public string TwoNumbersPlus(int number1, int number2)
        {
            var data = new { Greeting = String.Format("Hello, Your result {0}+{1}",number1,number2), Result = number1 + number2 };
            System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
            return js.Serialize(data);
        }

        [WebMethod(Description = "Вернуть заданный файл")]
        public void GetFile(string filename)
        {
            var response = Context.Response;
            response.ContentType = "application/octet-stream";
            response.AppendHeader("Content-Disposition", "attachment; filename=" + filename);
            using (System.IO.FileStream fs = new System.IO.FileStream(System.IO.Path.Combine(HttpContext.Current.Server.MapPath("~/Downloads/"), filename), System.IO.FileMode.Open))
            {
                Byte[] buffer = new Byte[256];
                Int32 readed = 0;

                while ((readed = fs.Read(buffer, 0, buffer.Length)) > 0)
                {
                    response.OutputStream.Write(buffer, 0, readed);
                    response.Flush();
                }
            }
        }
    }
}

using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Rodney_TeamCityTestApplication.Startup))]
namespace Rodney_TeamCityTestApplication
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

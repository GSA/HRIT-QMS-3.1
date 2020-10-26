using System;
using System.IO;
using System.Globalization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc.Razor;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.Extensions.Hosting;
using QmsCore.Services;
using QMS.Helpers;
using QMS.Validators;
using QMS.Utils;

namespace QMS
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // services.Configure<CookiePolicyOptions>(options =>
            // {
            //     // This lambda determines whether user consent for non-essential cookies is needed for a given request.
            //     options.CheckConsentNeeded = context => true;
            //     options.MinimumSameSitePolicy = SameSiteMode.None;
            // });

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register CorrectiveActionService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<ICorrectiveActionService, CorrectiveActionService>();
            //////////////////////////////////////////////////////////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register UserService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IUserService, UserService>();
            //////////////////////////////////////////////////////////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register EmployeeService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IEmployeeService, EmployeeService>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register NotificationService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<INotificationService, NotificationService>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register MenuBuilderService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IMenuBuilderService, MenuBuilderService>();
            //////////////////////////////////////////////////////////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register ReferenceService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IReferenceService, ReferenceService>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register EmailService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IEmailService, EmailService>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register UserAdminService
            //////////////////////////////////////////////////////////////////////////////////////////          
            //services.AddScoped<IUserAdminService, UserAdminService>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register RoleService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IRoleService, RoleService>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register PermissionService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IPermissionService, PermissionService>();
            //////////////////////////////////////////////////////////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register OrganizationService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IOrganizationService, OrganizationService>();
            //////////////////////////////////////////////////////////////////////////////////////////
           
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register DataErrorService
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IDataErrorService, DataErrorService>();
            //////////////////////////////////////////////////////////////////////////////////////////


            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register UserAdminHelper
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IUserAdminHelper, UserAdminHelper>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Role RoleValidator
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IRoleValidator, RoleValidator>();

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register PermissionValidator
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IPermissionValidator, PermissionValidator>();
            //////////////////////////////////////////////////////////////////////////////////////////
            
            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register UAUserUtil
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IUAUserUtil, UAUserUtil>();
            //////////////////////////////////////////////////////////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////////// 
            // Register UserFormUtil
            //////////////////////////////////////////////////////////////////////////////////////////          
            services.AddScoped<IUserFormUtil, UserFormUtil>();
            //////////////////////////////////////////////////////////////////////////////////////////


            //////////////////////////////////////////////////////////////////////////////////////////
            // Allow custom components to get to the HTTP context (i.e.LoginController).
            //////////////////////////////////////////////////////////////////////////////////////////
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            services.AddHttpContextAccessor();

            //////////////////////////////////////////////////////
            // Configure cookie policy:
            //////////////////////////////////////////////////////
            //   - Ensures that all cookies are marked as secure 
            //   - Ensures that HTTPS is used for data transfer
            //   - Required to pass security scan
            /////////////////////////////////////////////////////
            services.Configure<CookiePolicyOptions>(options =>
            {
                options.Secure = CookieSecurePolicy.Always;
            });

            //////////////////////////////////////////////////////////////////////////////////////////
            // Add data protection to enable cookie sharing.
            //////////////////////////////////////////////////////////////////////////////////////////
            var appsettingsDirectory = Environment.GetEnvironmentVariable("APPSETTINGS_DIRECTORY");
            var keyRingDirectoryInfo = new DirectoryInfo(Path.Combine(appsettingsDirectory, "KeyRing"));

            Console.WriteLine("==============================================================================================================");
            Console.WriteLine("[Startup] => appsettingsDirectory: '"    + appsettingsDirectory + "'");
            Console.WriteLine("[Startup] => keyRingDirectoryInfo: '"    + keyRingDirectoryInfo.ToString() + "'");
            Console.WriteLine("[Startup] => SharedApplicationName: '"   + Configuration["SharedApplicationName"] + "'");
            Console.WriteLine("[Startup] => SharedCookieName: '"        + Configuration["SharedCookieName"] + "'");
            Console.WriteLine("[Startup] => SessionCookieName: '"        + Configuration["SessionCookieName"] + "'");
            Console.WriteLine("[Startup] => sessionTimeoutSeconds: '"   + Configuration["CookieAuthentication:ExpireMinutes"] + "'");
            Console.WriteLine("==============================================================================================================");

            services.AddDataProtection()
                .PersistKeysToFileSystem(keyRingDirectoryInfo)
                .SetApplicationName(Configuration["SharedApplicationName"]);
            
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            // Cookie authentication:
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            //   - Configures cookie authentication 
            //   - Sets cookie authentication as the default authentication scheme for the application. 
            //   - An encrypted cookie will be created after user has successfully authenticated via SecureAuth. 
            //   - This cookie will identity the user to your application. 
            //   - The user’s browser will pass the cookie with each subsequent request.
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            services.AddAuthentication(options =>
            {
                options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
            }).AddCookie(options =>
            {
                options.Cookie.HttpOnly = true;
                options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
                options.Cookie.Name = Configuration["SharedCookieName"];
                options.LoginPath = "/Home/Index";
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////
            // Set session timeout:
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            double sessionTimeoutSeconds = Int32.Parse(Configuration["CookieAuthentication:ExpireMinutes"]) * 60;
            services.ConfigureApplicationCookie(options =>
            {
                options.Cookie.Expiration = TimeSpan.FromSeconds(sessionTimeoutSeconds);
                options.ExpireTimeSpan = TimeSpan.FromSeconds(sessionTimeoutSeconds);
                options.SlidingExpiration = false;
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////
            // Add support for sessions.
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            services.AddSession(options =>
            {
                options.Cookie.Name = Configuration["SessionCookieName"];
                options.IdleTimeout = TimeSpan.FromSeconds(sessionTimeoutSeconds);
                options.Cookie.IsEssential = true;
            });

            // Add the localization services to the services container
            services.AddLocalization(options => options.ResourcesPath = "Resources");

            // Add the Kendo UI services to the services container.
            //services.AddKendo();

            services.AddMvc()
                // Add support for finding localized views, based on file name suffix, e.g. Index.fr.cshtml
                .AddViewLocalization(LanguageViewLocationExpanderFormat.Suffix)
                // Add support for localizing strings in data annotations (e.g. validation messages) via the
                // IStringLocalizer abstractions.
                .AddDataAnnotationsLocalization();
                //.SetCompatibilityVersion(CompatibilityVersion.Version);

            // Configure supported cultures and localization options
            services.Configure<RequestLocalizationOptions>(options =>
            {
                var supportedCultures = new[]
                {
                    new CultureInfo("en-US")
                };

                // State what the default culture for your application is. This will be used if no specific culture
                // can be determined for a given request.
                options.DefaultRequestCulture = new RequestCulture(culture: "en-US", uiCulture: "en-US");

                // You must explicitly state which cultures your application supports.
                // These are the cultures the app supports for formatting numbers, dates, etc.
                options.SupportedCultures = supportedCultures;

                // These are the cultures the app supports for UI strings, i.e. we have localized resources for.
                options.SupportedUICultures = supportedCultures;
            });


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILoggerFactory loggerFactory)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            // Not working
            //app.UseStatusCodePagesWithRedirects("/StatusCode?code={0}");

            app.UseStatusCodePages("text/plain", "Status code page, status code: {0}");     
                
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            ///////////////////////////////////////////////////////////////////////////////////////
            // Use CookiePolicy configured in the Startup.ConfigureServices (above)
            ///////////////////////////////////////////////////////////////////////////////////////
            app.UseCookiePolicy();

            ///////////////////////////////////////////////////////////////////////////////////////
            // Use Cookie Authentication scheme configured in the Startup.ConfigureServices (above)
            ///////////////////////////////////////////////////////////////////////////////////////
            app.UseAuthentication();

            ///////////////////////////////////////////////////////////////////////////////////////
            // Use Session management configured in the Startup.ConfigureServices (above)
            ///////////////////////////////////////////////////////////////////////////////////////
            app.UseSession();

            //app.UseMvc(routes =>
            //{
            //    routes.MapRoute(
            //        name: "default",
            //        template: "{controller=Home}/{action=Index}/{id?}");
            //});

            app.UseRouting();
            app.UseAuthentication();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute("default", "{controller=Home}/{action=Index}/{id?}");
            });


            string logFileDirectory = Environment.GetEnvironmentVariable("LOGFILE_DIRECTORY");
            System.Console.WriteLine($"[Startup][Configure] => (logFileDirectory): '{logFileDirectory}'");
            if ( String.IsNullOrEmpty(logFileDirectory) == false)
            {
                System.Console.WriteLine("[Startup][Configure] => (Add log file): " + logFileDirectory + "/QMS-{Date}.log");
                loggerFactory.AddFile(logFileDirectory + "/QMS-{Date}.log");
            }  

        }
    }
}

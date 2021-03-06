using System;
using System.Data.SqlClient;
using ThrowawayDb;
using Xunit;
using Xunit.Abstractions;

namespace db_integrationtests
{
    public class UnitTest1
    {

        string Username = Environment.GetEnvironmentVariable("TestUser");
        string Password = Environment.GetEnvironmentVariable("TestPassword");
        string Host = Environment.GetEnvironmentVariable("TestHost");
        string Database = Environment.GetEnvironmentVariable("TestDatabase");
        
        private readonly ITestOutputHelper testOutputHelper;

        public UnitTest1(ITestOutputHelper testOutputHelper)
        {
            this.testOutputHelper = testOutputHelper;
        }

        [Fact]
        public void Can_Select_1_From_Database()
        {

            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

            builder.DataSource = Host; 
            builder.UserID = Username;            
            builder.Password = Password;     
            builder.InitialCatalog = Database;
            // builder.TrustServerCertificate = true;

            
            testOutputHelper.WriteLine($"Accessing database {Database}");

            using var connection = new SqlConnection(builder.ConnectionString);
            connection.Open();
            using var cmd = new SqlCommand("SELECT 1", connection);
            var result = Convert.ToInt32(cmd.ExecuteScalar());
            
            testOutputHelper.WriteLine(result.ToString());
            
            Assert.Equal(1, result);

        }
    }
}

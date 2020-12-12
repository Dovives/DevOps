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
        
        private readonly ITestOutputHelper testOutputHelper;

        public UnitTest1(ITestOutputHelper testOutputHelper)
        {
            this.testOutputHelper = testOutputHelper;
        }

        [Fact]
        public void Can_Select_1_From_Database()
        {
            using var database = ThrowawayDatabase.Create(
                Username, 
                Password, 
                Host
            );
            
            testOutputHelper.WriteLine($"Created database {database.Name}");

            using var connection = new SqlConnection(database.ConnectionString);
            connection.Open();
            using var cmd = new SqlCommand("SELECT 1", connection);
            var result = Convert.ToInt32(cmd.ExecuteScalar());
            
            testOutputHelper.WriteLine(result.ToString());
            
            Assert.Equal(1, result);
            
        }
    }
}

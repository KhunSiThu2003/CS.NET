using System.Configuration;

namespace Online_Banking_Transaction
{
    public static class Common
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["OnlineBankingDB"].ConnectionString;
        }
    }
}
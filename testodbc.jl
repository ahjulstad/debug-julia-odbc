import Pkg
Pkg.activate(".")
# Pkg.add(["ODBC", "DBInterface", "DataFrames"])
using Revise
Revise.track(Base)
import ODBC
using DBInterface
using DataFrames

ODBC.adddriver("ODBC Driver 18 for SQL Server", "/opt/microsoft/msodbcsql18/lib64/libmsodbcsql-18.3.so.1.1")

# ODBC.setdebug(true, "odbcdebug.log")

mssql = ODBC.Connection("Driver={ODBC Driver 18 for SQL Server};Server=127.0.0.1;Encrypt=no", "sa", "msSQ_F123")

res = DBInterface.execute(mssql, 
"SELECT CONVERT(uniqueidentifier, 'ABCD0000-0000-0000-1234-000000000000') AS anid, 'ABCD0000-0000-0000-1234-000000000000' AS strid",
debug=true)

for r in Tables.rows(res)
    print(r)
end

# ODBC.Row:
#  :anid   UUID("00000000-0000-3412-0000-0000abcd0000")
#  :strid  "ABCD0000-0000-0000-1234-000000000000"

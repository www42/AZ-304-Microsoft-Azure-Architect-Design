dotnet --info

cd tj/Lab_SQL
mkdir az30303a1

cp az30303a1.csproj az30303a1
cp Program.cs az30303a1
cd az30303a1/

dotnet new console

# edit az30303a1.csproj
# edit Program.cs

dotnet restore
dotnet run

# cleanup
cd ..
rm -r az30303a1
#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM microsoft/iis
 
RUN mkdir C:\myapp
RUN powershell -NoProfile -Command \
    Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45; \
    Import-Module IISAdministration; \
    New-IISSite -Name "WebApplication1" -PhysicalPath C:\myapp -BindingInformation "*:8000:"
 
EXPOSE 8000
 
ADD bin/ /myapp

#FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-nanoserver-1903 AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1-nanoserver-1903 AS build
#WORKDIR /src
#COPY ["WebApplication1.csproj", ""]
#RUN dotnet restore "./WebApplication1.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "WebApplication1.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "WebApplication1.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "WebApplication1.dll"]
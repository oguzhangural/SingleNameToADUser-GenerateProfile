cls
$name = Read-Host "Lütfen Kullanıcının Görünen Adını Giriniz. [Örnek: Elliot Alderson]"
$ulke = Read-Host "Lütfen Başlayacağı Ülkeyi Seçiniz. [Turkey-Amerika-Hollanda]"
if ($ulke -eq "Turkey") {
        $city= "Turkey"
        $streetaddress = "Sarıyer/Maslak"
        $Country = "Tr"
}elseif ($ulke -eq "Amerika") {
        $city = "Amerika"
        $streetaddress = "123 Main Street, Apt 4B,New York, USA"
        $Country = "Us"
}elseif ($ulke -eq "Hollanda") {
        $city = "Hollanda"
        $streetaddress = "Keizersgracht 123, 1015 CJ Amsterdam, Netherlands"
        $Country = "NL"
}

$part = $name -split ' '
$givenname = $part[0]
$surname = $part[1]
$samaccountname = $givenname.ToLower() + "." + $surname.ToLower()
$domainname = "relding.local"
$userprincipalname = $samaccountname + "@" + $domainname
$email = "@relding.com"
$emailaddress = $samaccountname+$email
$password = ConvertTo-SecureString "Password1" -AsPlainText -Force
$path = "OU=USER'S,OU=RELDING.LOCAL,DC=relding,DC=local"
$description = "Personel of The Organization"
$title = "Software Engineer"
$company = "Relding Software"
$groups = @("VPN","Relding All Group")

New-ADUser -Name $name -DisplayName $name -GivenName $givenname -Surname $surname -SamAccountName $samaccountname -UserPrincipalName $userprincipalname -EmailAddress $emailaddress -AccountPassword $password -Path $path -Enabled $true -Company $company -StreetAddress $streetaddress -Country $Country -City $city -Description $description -Title $title
foreach ($g in $groups){
    Add-ADGroupMember -Identity $g -Members $samaccountname
}
    Write-Host "
    Kullanıcı Oluşturuldu, Grup Tanımlamaları Yapıldı.
    İsim & Soyisim: $name
    Mail Adresi: $emailaddress
    Şifresi: Password1 "
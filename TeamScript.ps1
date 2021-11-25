##Conexion Teams
Function connection{

$credential = Get-Credential
Connect-MicrosoftTeams -Credential $credential
}
connection


##Estructura de funciones Básicas

##Menu
Function showmenu {
    Clear-Host
    Write-Host "Menu..."
    Write-Host "1. Añadir DDI"
    Write-Host "2. Comprobar DDI"
    Write-Host "3. Eliminar DDI"
    Write-Host "4. Exit"
}

#Añadir DDi


Function addDdi{


do{

##Variables

$correo = Read-Host -Prompt "Introduce el correo: "
$ddi = Read-Host -Prompt "Introduce DDI: "
$extension =  Read-Host -Prompt "Introduce extensión: "

##Confirmacion de Variables

$correo
$ddi
$extension

$valor =  Read-Host -Prompt "Datos correctos (y/n)?"



if($valor -eq "y"){



  Set-CsUser -Identity $correo -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -OnPremLineURI "tel:+34$ddi;ext=$extension"

  Grant-CsOnlineVoiceRoutingPolicy -Identity $correo -PolicyName “Worldwide”

  Get-CsOnlineUser -Identity $correo | fl UserPrincipalName,OnlineVoice*,OnPremLineURI;



}

}while ($valor -ne "y")

}


##VerDDi

Function verDdi($correo){

    Get-CsOnlineUser -Identity $correo | fl UserPrincipalName,OnlineVoice*,OnPremLineURI;
}


## BorrarDdi

Function borrarDdi(){

    $correo = Read-Host -Prompt "Introduce el correo "

    Set-CsUser -Identity $correo -OnPremLineURI $null

    Get-CsOnlineUser -Identity $correo | fl UserPrincipalName,OnlineVoice*,OnPremLineURI;

}





showmenu

while(($inp = Read-Host -Prompt "Select an option") -ne "4"){

switch($inp){
        1 {
             addDdi
             pause;
             break
        }
        2 {

              $correo = Read-Host -Prompt "Introduce el correo:  "
		verDdi($correo)

             pause;
             break


           
        }
        3 {

            borrarDdi
            pause;
            break
            }
        4 {"Exit"; break}
        default {Write-Host -ForegroundColor red -BackgroundColor white "Invalid option. Please select another option";pause}
        
    }

showmenu
}

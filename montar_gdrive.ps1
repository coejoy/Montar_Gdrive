# |=====================================|
# | SCRIPT DE INSTALAÇÃO E CONFIGURAÇÃO |
# | AUTOMATIZADA DO GDRIVE             |
# |-------------------------------------|
# | CRIADO POR: JOYCE SILVA              |
# | GITHUB: github.com/coejoy           |
# | DATA DE CRIAÇÃO: 12/01/2024          |
# |=====================================|

# **Nota:** Este script pressupõe a instalação prévia do módulo PowerShell para interagir com o Google Drive. 
# Você pode instalá-lo usando o PowerShellGet:
# Install-Module GoogleDrive -Scope CurrentUser

# Equivalente ao sudo apt-get update && sudo apt-get install google-drive-ocamlfuse -y
# A instalação do módulo GoogleDrive no PowerShell substitui a instalação do ocamlfuse.

# Criar diretórios
New-Item -ItemType Directory -Path "C:\Google Drive\MEU DRIVE" -Force
New-Item -ItemType Directory -Path "C:\Google Drive\TI" -Force

# Montar o drive e criar o login
# **Ajustar as credenciais e a forma de autenticação conforme a documentação do módulo GoogleDrive**
Connect-GoogleDrive -Scope "https://www.googleapis.com/auth/drive" -Credential (Get-Credential)

# **Assumir que os comandos abaixo são equivalentes às chamadas do ocamlfuse no Bash**
# **Verificar a documentação do módulo GoogleDrive para a sintaxe correta**
New-Item -ItemType SymbolicLink -Path "C:\Google Drive\MEU DRIVE" -Target "Google Drive:/MEU DRIVE"
New-Item -ItemType SymbolicLink -Path "C:\Google Drive\TI" -Target "Google Drive:/TI"

# Criar um script para montagem automática
$scriptContent = @"
Connect-GoogleDrive -Scope "https://www.googleapis.com/auth/drive" -Credential (Get-Credential)
# ... outras ações de montagem ...
"@

$scriptPath = "C:\scripts\montar_drive.ps1"
$scriptContent | Out-File -FilePath $scriptPath

# Adicionar à tarefa agendada
# **Ajustar a configuração da tarefa agendada conforme necessário**
Register-ScheduledTask -Action {Start-Process powershell -ArgumentList "-File ""$scriptPath"""} -Trigger (New-ScheduledTaskTrigger -AtLogon) -RunLevel Highest

# Mudar o id quando necessário
# **Adaptar para a sintaxe correta do módulo GoogleDrive**
# Set-GoogleDriveItem -Id "0ACDmg_HUtRFlUk9PVA" -Properties @{team_drive_id = "0ACDmg_HUtRFlUk9PVA"}

Write-Host "Reiniciando a máquina para aplicar as alterações"
Restart-Computer

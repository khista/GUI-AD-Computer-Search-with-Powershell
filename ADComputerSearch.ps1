# Written by Jacob Keil / 2019

# Loads needed Assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Windows.Forms.Application]::EnableVisualStyles();

# Puts search into variable $adpc and uses that string to filter search the current domains computer
function search_ADPC {  
    $adpc = $textbox_Search.Text
    $adpc = "*$adpc*"

    $adpc_Result = Get-ADComputer -Filter {name -like $adpc} -Properties IPv4Address,Description,whenCreated | Format-List Name,IPv4Address,Description,Enabled,whenCreated | Out-String;
    $output_TextBox.Text = $adpc_Result
}

# Main form
$search_AdTool = New-Object System.Windows.Forms.Form
    $search_AdTool.Text = "AD Computer Search v0.1"
    $search_AdTool.Size = New-Object System.Drawing.Size(674,500)
    $search_AdTool.FormBorderStyle = "FixedDialog"
    $search_AdTool.TopMost = $true
    $search_AdTool.MaximizeBox = $false
    $search_AdTool.MinimizeBox = $true
    $search_AdTool.ControlBox = $true
    $search_AdTool.StartPosition = "CenterScreen"
    $search_AdTool.Font = "Courier New"
 
# Textbox search label 
$label_Search = New-Object System.Windows.Forms.Label
    $label_Search.Location = New-Object System.Drawing.Size(195,18)
    $label_Search.Size = New-Object System.Drawing.Size(265,32)
    $label_Search.TextAlign = "MiddleCenter"
    $label_Search.Text = "Computer Name: "
    $search_AdTool.Controls.Add($label_Search)

# Search button that executes the computer search funtion
$button_Search = New-Object System.Windows.Forms.Button
    $button_Search.Location = New-Object System.Drawing.Size(195,80)
    $button_Search.Size = New-Object System.Drawing.Size(266,24)
    $button_Search.TextAlign = "MiddleCenter"
    $button_Search.Text = "Search"
    $button_Search.Add_Click({search_ADPC})
    $search_AdTool.Controls.Add($button_Search)

# Search textbox
$textbox_Search = New-Object System.Windows.Forms.TextBox
    $textbox_Search.Location = New-Object System.Drawing.Size(195,50)
    $textbox_Search.Size = New-Object System.Drawing.Size(266,37)
    $search_AdTool.Controls.Add($textbox_Search)

# Output textbox
$output_TextBox = New-Object System.Windows.Forms.TextBox 
    $output_TextBox.Multiline = $True;
    $output_TextBox.Location = New-Object System.Drawing.Size(16,130) 
    $output_TextBox.Size = New-Object System.Drawing.Size (627,314)
    $output_TextBox.ScrollBars = "Vertical"
    $output_TextBox.ReadOnly = $True;
    $search_AdTool.Controls.Add($output_TextBox)

# Allows the form to be seen
$search_AdTool.Add_Shown({$search_AdTool.Activate()})
[void] $search_AdTool.ShowDialog()

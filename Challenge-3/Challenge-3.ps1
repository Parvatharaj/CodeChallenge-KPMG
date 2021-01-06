
Function GetValueFromJsonByKeys([string]$inputJson, [string] $inputKey)
{
    $inputObj = $inputJson | ConvertFrom-Json    
    
    foreach($key in $inputKey.Split("/"))
    {  
      $value = $inputObj.$key

      if([string]::IsNullOrWhiteSpace($value))
      {
        return "Invalid Keys - $key"
      }

      $inputObj = $value
    }
    return $value
}

#Positive scenario 1 - with 3 levels
Function Test-ValidInputWith3Levels()
{    
    $value = '{"a":{"b":{"c":"d"}}}'
    $keys = "a/b/c"

    $result = GetValueFromJsonByKeys $value $keys

    if($result -ne 'd')
    {
       Write-Error "Test-ValidInputWith3Levels($keys) scenario failed"
       return
    }
    Write-Host "Test-ValidInputWith3Levels($keys) scenario success"    
}

#Positive scenario 2 - with 2 levels
Function Test-ValidInputWith2Levels()
{    
    $value = '{"parvath": {"place": "edinburgh","country":"scotland"}, "chinna": {"place": "london","country":"england"}}'
    $keys = "parvath/country"

    $result = GetValueFromJsonByKeys $value $keys

    if($result -ne 'scotland')
    {
      Write-Error "Test-ValidInputWith2Levels($keys) scenario failed"    
      return
    }
    Write-Host "Test-ValidInputWith2Levels($keys) scenario success"    
}

#Negative scenario 3 - with 2 levels
Function Test-InValidInput()
{    
    $value = '{"parvath": {"place": "edinburgh","country":"scotland"}, "chinna": {"place": "london","country":"england"}}'
    $keys = "Invalid-Key"

    $result = GetValueFromJsonByKeys $value $keys

    if(-not($result.Contains("Invalid Keys -") ))
    {      
      Write-Error "Test-InValidInput($keys) scenario failed" 
      return
    }    
    Write-Host "Test-InValidInput($keys) scenario success"    
}

Test-ValidInputWith2Levels
Test-ValidInputWith3Levels
Test-InValidInput




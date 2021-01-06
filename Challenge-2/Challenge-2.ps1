Function Get-Metadata([string] $uri)
{
    $header = @{"Metadata"="true"}
    
    $response = Invoke-RestMethod -Headers $header -Method GET -Uri $uri | ConvertTo-Json
    return $response
}

Function Get-MetadataInstance()
{    
    $uri = "http://169.254.169.254/metadata/instance?api-version=2020-09-01"
    return Get-Metadata $uri    
}

Function Get-MetadataInstanceWithKeysByApiQuery([string] $inputKey)
{       
   $uri = "http://169.254.169.254/metadata/instance/{0}?api-version=2020-09-01" -f $inputKeys      
   return Get-Metadata $uri   
}

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

Function Get-MetadataInstanceWithKeys([string] $inputKey)
{
    try
    {      
        $uri = "http://169.254.169.254/metadata/instance?api-version=2020-09-01"
        $response =  Get-Metadata $uri    

        if([string]::IsNullOrWhiteSpace($response))
        {
            return $response
        }        
        
        return GetValueFromJsonByKeys $response $inputKey | ConvertTo-Json               
    }
    catch [exception]
    {
        write-host "Error Details - $($_.Exception.Message)"
        throw "Error: Whilst Calling meta instance RESTAPI"
    }
}


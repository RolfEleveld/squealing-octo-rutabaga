# Marbitec fna Processing
Marbitec wants to process the setof fna files for having a complete picture of all complete genome structures
The process is triggered from a PowerShell script in the private repository which also includes the answer file.
When the ARM is deployed using the button below then the Dashboard will request the user to input the required data.

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FRolfEleveld%2Fsquealing-octo-rutabaga%2Fmaster%2Fazuredeploy.json)
[![Visualize](http://armviz.io/visualizebutton.png)](http://armviz.io/#/?load=https://raw.githubusercontent.com/RolfEleveld/squealing-octo-rutabaga/master/azuredeploy.json)

## Intent
To set up and crate an environmnt for processing the fna files using [MUMmer 3.23](http://mummer.sourceforge.net) or   
[ncbi-blast-2.3+](ftp://ftp.ncbi.nih.gov/blast/) from the python [average_nucleotide_identity.py](https://github.com/widdowquinn/pyani) script with a possibility to run this script in a multi-processing scale out way.

## Reference
TBA

# License
Copyright 2015 Rolf Eleveld, All sources and links have their respective owners.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

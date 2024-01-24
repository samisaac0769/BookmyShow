<!DOCTYPE html>
<html>
  <head>
    <title>Hello, World!</title>
    <link rel="stylesheet" href="styles.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@2.0.1/dist/css/multi-select-tag.css">
    <script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@2.0.1/dist/js/multi-select-tag.js"></script>
  </head>
  <body>
    <select name="countries" id="countries" multiple>
      <option value="1">Afghanistan</option>
      <option value="2">Australia</option>
      <option value="3">Germany</option>
      <option value="4">Canada</option>
      <option value="5">Russia</option>
    </select>

    <button type="button" onclick="setSelectedOptions()">Set Options</button>

    <script>
      var multiSelectTag = new MultiSelectTag('countries');

      function setSelectedOptions() {
        console.log("sdasd");
        // Get the select element
        var countriesSelect = document.getElementById('countries');

        // Set multiple options using an array of selected values
        var selectedValues = ["1", "3", "5"];

        // Deselect all options
        for (var i = 0; i < selectedValues.length; i++) {
          multiSelectTag.value(selectedValues[i]);
        }


        
      }
    </script>
  </body>
</html>

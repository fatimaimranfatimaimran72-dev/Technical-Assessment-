<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Notes App</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body>

  <div class="container">
    <h1>My Notes</h1>

    <!-- form -->
    <div class="form-box">
      <input type="text" id="titleInput" placeholder="Title (optional)" />
      <textarea id="bodyInput" placeholder="Write your note here..." rows="5"></textarea>
      <div class="form-buttons">
        <button id="submitBtn" onclick="handleSubmit()">Add Note</button>
        <button id="cancelBtn" onclick="handleCancel()" style="display:none;">Cancel</button>
      </div>
    </div>

    <!-- search -->
    <div id="searchWrapper" style="display:none;" class="search-wrapper">
      <input type="text" id="searchInput" placeholder="Search notes..." oninput="renderNotes()" />
    </div>

    <!-- notes list -->
    <div id="emptyMsg" class="empty-msg">No notes yet. Add one above!</div>
    <div id="notesList"></div>
  </div>

  <script src="app.js"></script>

</body>
</html>

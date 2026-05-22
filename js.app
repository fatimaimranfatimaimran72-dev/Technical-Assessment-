// all notes stored in memory, saved to localStorage
let notes = [];
let editId = null;

// load from localStorage on page load
window.addEventListener("DOMContentLoaded", () => {
  const saved = localStorage.getItem("my_notes");
  if (saved) {
    try {
      notes = JSON.parse(saved);
    } catch (e) {
      // corrupted data, start fresh
      notes = [];
    }
  }
  renderNotes();
});

function saveToStorage() {
  localStorage.setItem("my_notes", JSON.stringify(notes));
}

function handleSubmit() {
  const title = document.getElementById("titleInput").value.trim();
  const body = document.getElementById("bodyInput").value.trim();

  if (!body) return; // body is required

  if (editId !== null) {
    // update existing note
    notes = notes.map((n) => {
      if (n.id === editId) {
        return { ...n, title, body, updatedAt: Date.now() };
      }
      return n;
    });
    editId = null;
  } else {
    // create new note
    const newNote = {
      id: Date.now(),
      title,
      body,
      createdAt: Date.now(),
      updatedAt: Date.now(),
    };
    notes.unshift(newNote); // add to top
  }

  saveToStorage();
  clearForm();
  renderNotes();
}

function handleEdit(id) {
  const note = notes.find((n) => n.id === id);
  if (!note) return;

  editId = id;
  document.getElementById("titleInput").value = note.title;
  document.getElementById("bodyInput").value = note.body;
  document.getElementById("submitBtn").textContent = "Update Note";
  document.getElementById("cancelBtn").style.display = "inline-block";

  window.scrollTo({ top: 0, behavior: "smooth" });
  renderNotes(); // re-render to highlight the editing card
}

function handleDelete(id) {
  if (!confirm("Delete this note?")) return;

  notes = notes.filter((n) => n.id !== id);

  // if we were editing this note, cancel the edit
  if (editId === id) {
    clearForm();
  }

  saveToStorage();
  renderNotes();
}

function handleCancel() {
  clearForm();
  renderNotes();
}

function clearForm() {
  editId = null;
  document.getElementById("titleInput").value = "";
  document.getElementById("bodyInput").value = "";
  document.getElementById("submitBtn").textContent = "Add Note";
  document.getElementById("cancelBtn").style.display = "none";
}

function formatDate(ts) {
  return new Date(ts).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });
}

function renderNotes() {
  const search = document.getElementById("searchInput")
    ? document.getElementById("searchInput").value.toLowerCase()
    : "";

  const filtered = notes.filter((n) => {
    return (
      n.title.toLowerCase().includes(search) ||
      n.body.toLowerCase().includes(search)
    );
  });

  const list = document.getElementById("notesList");
  const emptyMsg = document.getElementById("emptyMsg");
  const searchWrapper = document.getElementById("searchWrapper");

  // show/hide search bar
  if (notes.length > 0) {
    searchWrapper.style.display = "block";
  } else {
    searchWrapper.style.display = "none";
  }

  // empty state
  if (notes.length === 0) {
    emptyMsg.style.display = "block";
    emptyMsg.textContent = "No notes yet. Add one above!";
    list.innerHTML = "";
    return;
  }

  if (filtered.length === 0) {
    emptyMsg.style.display = "block";
    emptyMsg.textContent = "No notes match your search.";
    list.innerHTML = "";
    return;
  }

  emptyMsg.style.display = "none";

  list.innerHTML = filtered
    .map((note) => {
      const isEditing = editId === note.id;
      const dateLabel =
        note.updatedAt !== note.createdAt
          ? "Edited " + formatDate(note.updatedAt)
          : formatDate(note.createdAt);

      return `
      <div class="note-card ${isEditing ? "editing" : ""}">
        ${note.title ? `<div class="note-title">${escapeHtml(note.title)}</div>` : ""}
        <div class="note-body">${escapeHtml(note.body)}</div>
        <div class="note-footer">
          <span class="note-date">${dateLabel}</span>
          <div class="note-actions">
            <button class="edit-btn" onclick="handleEdit(${note.id})">Edit</button>
            <button class="delete-btn" onclick="handleDelete(${note.id})">Delete</button>
          </div>
        </div>
      </div>
    `;
    })
    .join("");
}

// prevent XSS when rendering user content
function escapeHtml(str) {
  const div = document.createElement("div");
  div.appendChild(document.createTextNode(str));
  return div.innerHTML;
}

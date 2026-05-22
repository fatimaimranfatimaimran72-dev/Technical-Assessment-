* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: sans-serif;
  background: #f3f4f6;
  color: #111;
  padding: 20px 16px;
}

.container {
  max-width: 680px;
  margin: 0 auto;
}

h1 {
  font-size: 24px;
  margin-bottom: 24px;
}

/* form */
.form-box {
  background: #f9f9f9;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 24px;
}

.form-box input[type="text"],
.form-box textarea {
  width: 100%;
  padding: 8px 10px;
  font-size: 14px;
  border: 1px solid #ccc;
  border-radius: 6px;
  margin-bottom: 10px;
  font-family: sans-serif;
  resize: vertical;
}

.form-box input[type="text"]:focus,
.form-box textarea:focus {
  outline: none;
  border-color: #2563eb;
}

.form-buttons {
  display: flex;
  gap: 8px;
}

#submitBtn {
  background: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  padding: 8px 18px;
  font-size: 14px;
  cursor: pointer;
}

#submitBtn:hover {
  background: #1d4ed8;
}

#cancelBtn {
  background: #e5e7eb;
  color: #333;
  border: none;
  border-radius: 6px;
  padding: 8px 14px;
  font-size: 14px;
  cursor: pointer;
}

#cancelBtn:hover {
  background: #d1d5db;
}

/* search */
.search-wrapper {
  margin-bottom: 16px;
}

.search-wrapper input {
  width: 100%;
  padding: 8px 10px;
  font-size: 14px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-family: sans-serif;
}

.search-wrapper input:focus {
  outline: none;
  border-color: #2563eb;
}

/* empty message */
.empty-msg {
  color: #888;
  font-size: 14px;
}

/* notes */
#notesList {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.note-card {
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 14px;
}

.note-card.editing {
  border-color: #2563eb;
}

.note-title {
  font-weight: 600;
  font-size: 15px;
  margin-bottom: 4px;
}

.note-body {
  font-size: 14px;
  color: #333;
  white-space: pre-wrap;
  line-height: 1.5;
}

.note-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
}

.note-date {
  font-size: 12px;
  color: #999;
}

.note-actions {
  display: flex;
  gap: 10px;
}

.note-actions button {
  font-size: 12px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
}

.edit-btn {
  color: #2563eb;
}

.edit-btn:hover {
  text-decoration: underline;
}

.delete-btn {
  color: #dc2626;
}

.delete-btn:hover {
  text-decoration: underline;
}

.no-results {
  color: #888;
  font-size: 14px;
}

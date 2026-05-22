# Technical-Assessment-
# Notes App

A simple notes app where you can create, edit, delete, and search notes. Notes persist between sessions using the Artifact storage API.

## How to run

Paste the contents of `notes-app.jsx` into a Claude React Artifact and it'll run right away — no install needed.

If you want to run it locally with Vite:

```bash
npm create vite@latest notes-app -- --template react
cd notes-app
npm install
npm run dev
```

Replace `src/App.jsx` with the contents of `notes-app.jsx`. You'll also need to add a shim for `window.storage` since that's specific to the Artifact environment:

```js
// add this at the top of App.jsx for local dev
window.storage = {
  get: async (key) => {
    const val = localStorage.getItem(key);
    return val ? { value: val } : null;
  },
  set: async (key, value) => {
    localStorage.setItem(key, value);
  },
};
```

## Features

- Add, edit, delete notes
- Optional title per note
- Search filters notes by title or body as you type
- Shows when a note was created/last edited
- Notes are saved and still there when you come back

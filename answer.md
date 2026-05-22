# ANSWERS.md

**1. How to run**

Paste `notes-app.jsx` into a Claude React Artifact — it runs instantly with no setup. The storage API is built into the Artifact environment so persistence just works out of the box.

For local dev, scaffold a Vite React project and drop the file in as `App.jsx`. You'll need to add a small `window.storage` shim pointing to `localStorage` since that API only exists in the Artifact runtime. Full steps are in the README.

---

**2. Stack choice**

React with the Artifact storage API. I picked React because I'm most comfortable with it and the component/state model is a natural fit for a list-based CRUD app — you get reactivity basically for free with `useState`. Managing this with vanilla JS and manual DOM updates would have gotten messy pretty quickly once I added search on top of the list.

For storage I went with `window.storage` (the Artifact key-value API) instead of something like SQLite or a hosted DB. The app doesn't need relational queries and the data is small, so a simple JSON blob under one key is totally fine. SQLite over WASM would have been overkill and added a big dependency for no real gain.

A worse choice would have been `localStorage` as the primary storage — it's synchronous and has a 5MB cap, and it doesn't work in the Artifact environment anyway without the shim.

---

**3. One real edge case**

Empty note guard in `handleSubmit` — line 43 in `notes-app.jsx`:

```js
if (!body.trim()) return;
```

If the body is empty and the user clicks "Add Note", nothing happens. Without this, you'd be able to save completely blank notes which would just show up as empty cards in the list with no way to tell them apart. The title is optional so I only check body — a note with just a title and no content isn't really a note.

I also handle the case in `handleDelete` where the note being deleted is currently open in the edit form — it clears the form so you're not left editing a note that no longer exists.

---

**4. AI usage**

I used Claude to help speed up a few things:

- Asked it to generate the initial `useEffect` pattern for loading/saving to `window.storage`. It gave me the basic structure (get on mount, set on notes change) and I adjusted it to add the `loaded` flag so the save effect doesn't fire before the load finishes and wipe the stored data. That was a bug in the first version it gave me.

- Used it to write the `formatDate` helper. It suggested using `toLocaleDateString` with options which I hadn't used before, so that was useful.

- Asked it to help me think through the edit flow — specifically whether to use a modal or inline editing. It laid out pros/cons of both and I went with the simpler approach (scroll-to-top + pre-fill the form) since a modal felt like more complexity than the feature needed.

Everything else I wrote directly.

---

**5. Honest gap**

There's no way to reorder notes. Right now new notes go to the top and that's it — you can't pin something important or drag things around. If I had more time I'd add at least a simple "pin" toggle that keeps certain notes at the top of the list regardless of when they were created. The data model already has everything I'd need (just add a `pinned: bool` field to each note), it's really just a UI thing I didn't get to.

Search is also pretty basic — it's just `includes()` on the lowercased strings. It doesn't handle typos or partial word matches in any smart way. Good enough for personal notes but I'd want something better if this were a real product.

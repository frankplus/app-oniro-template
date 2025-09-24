# Notes App for OpenHarmony

A simple and elegant note-taking application built with ArkTS for OpenHarmony devices.

## Features

- ✨ **Create Notes**: Easily create new notes with titles and rich content
- 📝 **Edit Notes**: Modify existing notes with a clean, intuitive interface
- 📋 **View Notes List**: Browse all your notes in an organized list view
- 🗑️ **Delete Notes**: Remove notes you no longer need with swipe-to-delete functionality
- 💾 **Persistent Storage**: Notes are automatically saved using OpenHarmony's preferences API
- 📅 **Timestamps**: See when each note was created and last modified

## Architecture

The app follows a clean architecture pattern with the following components:

### Data Layer
- **`Note.ets`**: Data model representing a note with id, title, content, and timestamps
- **`NotesService.ets`**: Service layer handling data persistence using OpenHarmony preferences

### UI Layer
- **`Index.ets`**: Entry point with splash screen and service initialization
- **`NotesListPage.ets`**: Main screen displaying list of notes with empty state
- **`NoteEditor.ets`**: Note creation and editing interface

## Technical Implementation

### ArkTS Compliance
The application follows ArkTS guidelines and avoids:
- Untyped object literals (uses proper interfaces)
- Object literals as type declarations
- Dynamic typing features that could impact performance

### Key Design Patterns
- **Singleton Pattern**: NotesService uses singleton pattern for global state management
- **Builder Pattern**: Uses ArkTS @Builder decorators for reusable UI components
- **Observer Pattern**: Uses @State decorators for reactive UI updates

### Data Persistence
- Uses OpenHarmony's `preferences` API for local data storage
- JSON serialization/deserialization for note data
- Automatic data synchronization between service and UI

## Building the Project

Build the project using the OpenHarmony build tools:

```bash
/home/francesco/command-line-tools/bin/hvigorw assembleHap --mode module -p product=default --stacktrace --no-parallel --no-daemon
```

## File Structure

```
entry/src/main/ets/
├── model/
│   └── Note.ets              # Note data model
├── utils/
│   └── NotesService.ets      # Data persistence service
├── pages/
│   ├── Index.ets             # App entry point
│   ├── NotesListPage.ets     # Main notes list view
│   └── NoteEditor.ets        # Note creation/editing
└── entryability/
    └── EntryAbility.ets      # Application ability
```

## User Experience

### Empty State
When no notes exist, the app displays a friendly empty state with:
- Note emoji icon
- "No notes yet" message
- Instructions to create the first note

### Notes List
- Clean card-based design
- Shows note title, preview of content, and timestamp
- Swipe-to-delete functionality
- Floating action button for creating new notes

### Note Editor
- Simple, distraction-free editing interface
- Title and content input fields
- Save/Cancel actions
- Works for both creating new notes and editing existing ones

## API Usage

The app demonstrates proper usage of several OpenHarmony APIs:
- **Preferences API**: For data persistence
- **Router API**: For navigation between pages
- **Context API**: For accessing application context

## Note on Deprecation Warnings

The build output shows some deprecation warnings for certain APIs. These are warnings only and do not affect functionality. The app uses the current stable APIs available in the OpenHarmony version being targeted.

## Future Enhancements

Potential improvements could include:
- Search functionality
- Note categories/tags
- Rich text formatting
- Export/import capabilities
- Cloud synchronization
- Note sharing
import { preferences } from '@kit.ArkData';
import { Note } from '../model/Note';

/**
 * Interface for note data structure used in persistence
 */
interface NoteData {
  id: string;
  title: string;
  content: string;
  createdAt: number;
  updatedAt: number;
}

/**
 * Service for managing note data persistence
 */
export class NotesService {
  private static instance: NotesService;
  private preferencesManager: preferences.Preferences | null = null;
  private readonly NOTES_KEY = 'saved_notes';

  private constructor() {}

  static getInstance(): NotesService {
    if (!NotesService.instance) {
      NotesService.instance = new NotesService();
    }
    return NotesService.instance;
  }

  async initialize(context: Context): Promise<void> {
    try {
      this.preferencesManager = await preferences.getPreferences(context, 'notes_db');
    } catch (error) {
      console.error('Failed to initialize preferences:', error);
    }
  }

  async saveNotes(notes: Note[]): Promise<void> {
    if (!this.preferencesManager) {
      return;
    }
    
    try {
      const notesData: NoteData[] = notes.map(note => {
        const data: NoteData = {
          id: note.id,
          title: note.title,
          content: note.content,
          createdAt: note.createdAt,
          updatedAt: note.updatedAt
        };
        return data;
      });
      
      const notesJson = JSON.stringify(notesData);
      await this.preferencesManager.put(this.NOTES_KEY, notesJson);
      await this.preferencesManager.flush();
    } catch (error) {
      console.error('Failed to save notes:', error);
    }
  }

  async loadNotes(): Promise<Note[]> {
    if (!this.preferencesManager) {
      return [];
    }

    try {
      const notesJson = await this.preferencesManager.get(this.NOTES_KEY, '[]') as string;
      const notesData = JSON.parse(notesJson) as NoteData[];

      return notesData.map(data => {
        const note = new Note();
        note.id = data.id;
        note.title = data.title;
        note.content = data.content;
        note.createdAt = data.createdAt;
        note.updatedAt = data.updatedAt;
        return note;
      });
    } catch (error) {
      console.error('Failed to load notes:', error);
      return [];
    }
  }

  async addNote(note: Note): Promise<void> {
    const notes = await this.loadNotes();
    notes.unshift(note); // Add new note at the beginning
    await this.saveNotes(notes);
  }

  async updateNote(updatedNote: Note): Promise<void> {
    const notes = await this.loadNotes();
    const index = notes.findIndex(note => note.id === updatedNote.id);
    if (index !== -1) {
      notes[index] = updatedNote;
      await this.saveNotes(notes);
    }
  }

  async deleteNote(noteId: string): Promise<void> {
    const notes = await this.loadNotes();
    const filteredNotes = notes.filter(note => note.id !== noteId);
    await this.saveNotes(filteredNotes);
  }
}
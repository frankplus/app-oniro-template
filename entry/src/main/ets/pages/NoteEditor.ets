import { router } from '@kit.ArkUI';
import { Note } from '../model/Note';
import { NotesService } from '../utils/NotesService';

/**
 * Interface for router parameters
 */
interface RouterParams {
  note?: Note;
}

@Entry
@Component
struct NoteEditor {
  @State title: string = '';
  @State content: string = '';
  @State isEditing: boolean = false;
  private note: Note | null = null;
  private notesService: NotesService = NotesService.getInstance();

  aboutToAppear(): void {
    const params = router.getParams() as RouterParams;
    if (params?.note) {
      this.note = params.note;
      this.title = this.note.title;
      this.content = this.note.content;
      this.isEditing = true;
    }
  }

  async saveNote(): Promise<void> {
    if (!this.title.trim() && !this.content.trim()) {
      // Don't save empty notes
      this.navigateBack();
      return;
    }

    try {
      if (this.isEditing && this.note) {
        // Update existing note
        this.note.update(this.title.trim(), this.content.trim());
        await this.notesService.updateNote(this.note);
      } else {
        // Create new note
        const newNote = new Note('', this.title.trim(), this.content.trim());
        await this.notesService.addNote(newNote);
      }
      this.navigateBack();
    } catch (error) {
      console.error('Failed to save note:', error);
    }
  }

  navigateBack(): void {
    router.back();
  }

  build() {
    Navigation() {
      Column() {
        // Title input
        TextInput({
          placeholder: 'Note title...',
          text: this.title
        })
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding(16)
          .margin({ left: 16, right: 16, top: 16, bottom: 8 })
          .onChange((value: string) => {
            this.title = value;
          })
          .placeholderFont({
            size: 20,
            weight: FontWeight.Medium
          })
          .placeholderColor('#CCCCCC')

        // Content input
        TextArea({
          placeholder: 'Start writing your note...',
          text: this.content
        })
          .fontSize(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding(16)
          .margin({ left: 16, right: 16, bottom: 16 })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.content = value;
          })
          .placeholderFont({
            size: 16
          })
          .placeholderColor('#CCCCCC')

        // Action buttons
        Row() {
          Button('Cancel')
            .fontSize(16)
            .fontColor('#666666')
            .backgroundColor('#F0F0F0')
            .borderRadius(8)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .layoutWeight(1)
            .margin({ right: 8 })
            .onClick(() => {
              this.navigateBack();
            })

          Button('Save')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#007DFF')
            .borderRadius(8)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .layoutWeight(1)
            .margin({ left: 8 })
            .onClick(() => {
              this.saveNote();
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')
    }
    .title(this.isEditing ? 'Edit Note' : 'New Note')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
  }
}
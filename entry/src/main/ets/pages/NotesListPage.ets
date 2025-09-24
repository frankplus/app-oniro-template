import { router } from '@kit.ArkUI';
import { Note } from '../model/Note';
import { NotesService } from '../utils/NotesService';

/**
 * Interface for navigation parameters
 */
interface NoteEditorParams {
  note?: Note;
}

/**
 * Interface for router options
 */
interface RouterOptions {
  url: string;
  params?: NoteEditorParams;
}

/**
 * Interface for NoteItem builder parameters
 */
interface NoteItemParams {
  note: Note;
  onEdit: () => void;
  onDelete: () => void;
}

@Entry
@Component
struct NotesListPage {
  @State notes: Note[] = [];
  private notesService: NotesService = NotesService.getInstance();

  aboutToAppear(): void {
    this.loadNotes();
  }

  onPageShow(): void {
    // Refresh notes when returning from note editor
    this.loadNotes();
  }

  async loadNotes(): Promise<void> {
    try {
      this.notes = await this.notesService.loadNotes();
    } catch (error) {
      console.error('Failed to load notes:', error);
    }
  }

  navigateToNewNote(): void {
    const options: RouterOptions = {
      url: 'pages/NoteEditor'
    };
    router.pushUrl(options).catch((error: Error) => {
      console.error('Navigation failed:', error);
    });
  }

  navigateToEditNote(note: Note): void {
    const options: RouterOptions = {
      url: 'pages/NoteEditor',
      params: { note: note }
    };
    router.pushUrl(options).catch((error: Error) => {
      console.error('Navigation failed:', error);
    });
  }

  async deleteNote(noteId: string): Promise<void> {
    try {
      await this.notesService.deleteNote(noteId);
      await this.loadNotes(); // Refresh the list
    } catch (error) {
      console.error('Failed to delete note:', error);
    }
  }

  build() {
    Navigation() {
      Column() {
        // Header with title and add button
        Row() {
          Text('My Notes')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .layoutWeight(1)

          Button() {
            Image($r('sys.media.ohos_ic_public_add'))
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
          }
          .width(48)
          .height(48)
          .backgroundColor('#007DFF')
          .borderRadius(24)
          .onClick(() => {
            this.navigateToNewNote();
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 8 })
        .justifyContent(FlexAlign.SpaceBetween)

        if (this.notes.length === 0) {
          // Empty state
          Column() {
            Text('📝')
              .fontSize(64)
              .margin({ bottom: 16 })

            Text('No notes yet')
              .fontSize(18)
              .fontColor('#666666')
              .margin({ bottom: 8 })

            Text('Tap the + button to create your first note')
              .fontSize(14)
              .fontColor('#999999')
              .textAlign(TextAlign.Center)
              .width('80%')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)
        } else {
          // Notes list
          List() {
            ForEach(this.notes, (note: Note) => {
              ListItem() {
                this.NoteItem({ 
                  note: note,
                  onEdit: () => this.navigateToEditNote(note),
                  onDelete: () => this.deleteNote(note.id)
                })
              }
              .swipeAction({
                end: this.SwipeDeleteButton(() => this.deleteNote(note.id))
              })
            }, (note: Note) => note.id)
          }
          .layoutWeight(1)
          .padding({ left: 16, right: 16 })
          .divider({
            strokeWidth: 1,
            color: '#F0F0F0',
            startMargin: 16,
            endMargin: 16
          })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')
    }
    .titleMode(NavigationTitleMode.Free)
    .hideBackButton(true)
  }

  @Builder
  NoteItem(params: NoteItemParams) {
    Row() {
      Column() {
        Text(params.note.title || 'Untitled')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 4 })

        if (params.note.content) {
          Text(params.note.content)
            .fontSize(14)
            .fontColor('#666666')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 8 })
        }

        Text(params.note.getFormattedDate())
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ bottom: 8 })
    .onClick(() => {
      params.onEdit();
    })
    .shadow({
      radius: 2,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  SwipeDeleteButton(onDelete: () => void) {
    Button() {
      Text('Delete')
        .fontSize(14)
        .fontColor('#FFFFFF')
    }
    .width(60)
    .height('100%')
    .backgroundColor('#FF4444')
    .borderRadius(0)
    .onClick(() => {
      onDelete();
    })
  }
}
import { router } from '@kit.ArkUI';
import { NotesService } from '../utils/NotesService';

/**
 * Interface for router options
 */
interface RouterOptions {
  url: string;
}

@Entry
@Component
struct Index {
  private notesService: NotesService = NotesService.getInstance();

  async aboutToAppear(): Promise<void> {
    // Initialize the notes service
    try {
      await this.notesService.initialize(getContext(this) as Context);
    } catch (error) {
      console.error('Failed to initialize notes service:', error);
    }
    
    // Navigate to notes list
    setTimeout(() => {
      const options: RouterOptions = {
        url: 'pages/NotesListPage'
      };
      router.replaceUrl(options).catch((error: Error) => {
        console.error('Navigation to NotesListPage failed:', error);
      });
    }, 100);
  }

  build() {
    RelativeContainer() {
      Column() {
        Text('📝')
          .fontSize(64)
          .margin({ bottom: 16 })

        Text('Notes App')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 8 })

        Text('Loading...')
          .fontSize(16)
          .fontColor('#666666')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .alignRules({
        center: { anchor: '__container__', align: VerticalAlign.Center },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F8F8F8')
  }
}
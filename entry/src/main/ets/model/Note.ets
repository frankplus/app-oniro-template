/**
 * Note data model
 */
export class Note {
  id: string = '';
  title: string = '';
  content: string = '';
  createdAt: number = Date.now();
  updatedAt: number = Date.now();

  constructor(id: string = '', title: string = '', content: string = '') {
    this.id = id || this.generateId();
    this.title = title;
    this.content = content;
    this.createdAt = Date.now();
    this.updatedAt = Date.now();
  }

  private generateId(): string {
    return 'note_' + Date.now() + '_' + Math.floor(Math.random() * 1000);
  }

  update(title: string, content: string): void {
    this.title = title;
    this.content = content;
    this.updatedAt = Date.now();
  }

  getFormattedDate(): string {
    const date = new Date(this.updatedAt);
    return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')} ${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`;
  }
}
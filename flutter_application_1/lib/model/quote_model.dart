class QuoteModel {
  dynamic name, wishes, learningQuotes, image, template;

  QuoteModel(this.name, this.wishes, this.learningQuotes, this.image, this.template);

  factory QuoteModel.fromMap({required Map data}) => QuoteModel(data['name'], data['wishes'], data['learningQuotes'], data['image'], data['template']);
}
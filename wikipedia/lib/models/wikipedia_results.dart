class WikipediaResults {
  String batchcomplete;
  ContinueObject continueObject;
  Query query;

  WikipediaResults({this.batchcomplete, this.continueObject, this.query});

  WikipediaResults.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    continueObject = json['continue'] != null
        ? new ContinueObject.fromJson(json['continue'])
        : null;
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchcomplete'] = this.batchcomplete;
    if (this.continueObject != null) {
      data['continue'] = this.continueObject.toJson();
    }
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    return data;
  }
}

class ContinueObject {
  int sroffset;
  String continueString;

  ContinueObject({this.sroffset, this.continueString});

  ContinueObject.fromJson(Map<String, dynamic> json) {
    sroffset = json['sroffset'];
    continueString = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sroffset'] = this.sroffset;
    data['continue'] = this.continueString;
    return data;
  }
}

class Query {
  Searchinfo searchinfo;
  List<Search> search;

  Query({this.searchinfo, this.search});

  Query.fromJson(Map<String, dynamic> json) {
    searchinfo = json['searchinfo'] != null
        ? new Searchinfo.fromJson(json['searchinfo'])
        : null;
    if (json['search'] != null) {
      search = new List<Search>();
      json['search'].forEach((v) {
        search.add(new Search.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchinfo != null) {
      data['searchinfo'] = this.searchinfo.toJson();
    }
    if (this.search != null) {
      data['search'] = this.search.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Searchinfo {
  int totalhits;
  String suggestion;
  String suggestionsnippet;

  Searchinfo({this.totalhits, this.suggestion, this.suggestionsnippet});

  Searchinfo.fromJson(Map<String, dynamic> json) {
    totalhits = json['totalhits'];
    suggestion = json['suggestion'];
    suggestionsnippet = json['suggestionsnippet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalhits'] = this.totalhits;
    data['suggestion'] = this.suggestion;
    data['suggestionsnippet'] = this.suggestionsnippet;
    return data;
  }
}

class Search {
  int ns;
  String title;
  int pageid;
  int size;
  int wordcount;
  String snippet;
  String timestamp;

  Search(
      {this.ns,
      this.title,
      this.pageid,
      this.size,
      this.wordcount,
      this.snippet,
      this.timestamp});

  Search.fromJson(Map<String, dynamic> json) {
    ns = json['ns'];
    title = json['title'];
    pageid = json['pageid'];
    size = json['size'];
    wordcount = json['wordcount'];
    snippet = json['snippet'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ns'] = this.ns;
    data['title'] = this.title;
    data['pageid'] = this.pageid;
    data['size'] = this.size;
    data['wordcount'] = this.wordcount;
    data['snippet'] = this.snippet;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

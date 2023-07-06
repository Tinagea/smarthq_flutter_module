class RecipeResponse {
  String? kind;
  Recipe? recipe;

  RecipeResponse({this.kind, this.recipe});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'] ?? "";
    recipe =
        json['recipe'] != null ? new Recipe.fromJson(json['recipe']) : Recipe.asEmpty();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.recipe != null) {
      data['recipe'] = this.recipe!.toJson();
    }
    return data;
  }
}

class Recipe {
  String? id;
  String? metaId;
  String? label;
  bool? isPublic;
  bool? isCommunityPublic;
  bool? isConsumerRecipe;
  bool? isValidated;
  bool? isScanToCook;
  bool? isCookbook;
  bool? isAutoCurated;
  String? appId;
  String? dateCreated;
  String? notes;
  List<String>? tags;
  double? rating;
  List<String>? ingredients;
  List<String>? barcodes;
  List<String>? speakableNames;
  List<String>? course;
  List<String>? mainIngredient;
  List<String>? dietaryPreference;
  List<String>? cuisine;
  List<String>? season;
  List<String>? capabilityInstructions;
  List<String>? styleInstructions;
  List<String>? parameterInstructions;
  List<MenuTreeInstructions>? menuTreeInstructions;
  List<Media>? media;
  List<Steps>? steps;
  List<IngredientObjects>? ingredientObjects;
  List<Equipment>? equipment;
  List<String>? sections;
  String? shortDescription;
  List<String>? domains;
  List<String>? affiliateBrands;
  String? mediaId;

  Recipe(
      {this.id,
      this.metaId,
      this.label,
      this.isPublic,
      this.isCommunityPublic,
      this.isConsumerRecipe,
      this.isValidated,
      this.isScanToCook,
      this.isCookbook,
      this.isAutoCurated,
      this.appId,
      this.dateCreated,
      this.notes,
      this.tags,
      this.rating,
      this.ingredients,
      this.barcodes,
      this.speakableNames,
      this.course,
      this.mainIngredient,
      this.dietaryPreference,
      this.cuisine,
      this.season,
      this.capabilityInstructions,
      this.styleInstructions,
      this.parameterInstructions,
      this.menuTreeInstructions,
      this.media,
      this.steps,
      this.ingredientObjects,
      this.equipment,
      this.sections,
      this.shortDescription,
      this.domains,
      this.affiliateBrands,
      this.mediaId});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    metaId = json['metaId'] ?? "";
    label = json['label'] ?? "";
    isPublic = json['isPublic'] ?? false;
    isCommunityPublic = json['isCommunityPublic'] ?? false;
    isConsumerRecipe = json['isConsumerRecipe'] ?? false;
    isValidated = json['isValidated'] ?? false;
    isScanToCook = json['isScanToCook'] ?? false;
    isCookbook = json['isCookbook'] ?? false;
    isAutoCurated = json['isAutoCurated'] ?? false;
    appId = json['appId'] ?? "";
    dateCreated = json['dateCreated'] ?? "";
    notes = json['notes'] ?? "";
    tags = json['tags'].cast<String>() ?? [];
    rating = json['rating'];
    ingredients = json['ingredients'].cast<String>() ?? [];
    barcodes = json['barcodes'].cast<String>() ?? [];
    speakableNames = json['speakableNames'].cast<String>() ?? [];
    course = json['course'].cast<String>() ?? [];
    mainIngredient = json['mainIngredient'].cast<String>() ?? [];
    dietaryPreference = json['dietaryPreference'].cast<String>() ?? [];
    cuisine = json['cuisine'].cast<String>() ?? [];
    season = json['season'].cast<String>() ?? [];
    capabilityInstructions = json['capabilityInstructions'].cast<String>() ?? [];
    styleInstructions = json['styleInstructions'].cast<String>() ?? [];
    parameterInstructions = json['parameterInstructions'].cast<String>() ?? [];
    if (json['menuTreeInstructions'] != null) {
      menuTreeInstructions = <MenuTreeInstructions>[];
      json['menuTreeInstructions'].forEach((v) {
        menuTreeInstructions!.add(new MenuTreeInstructions.fromJson(v));
      });
    }
    else {
      menuTreeInstructions = [MenuTreeInstructions.asEmpty()];
    }

    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    else {
      media = [];
    }

    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
    else {
      steps = [];
    }

    if (json['ingredientObjects'] != null) {
      ingredientObjects = <IngredientObjects>[];
      json['ingredientObjects'].forEach((v) {
        ingredientObjects!.add(new IngredientObjects.fromJson(v));
      });
    }
    else {
      ingredientObjects = [];
    }
    
    if (json['equipment'] != null) {
      equipment = <Equipment>[];
      json['equipment'].forEach((v) {
        equipment!.add(new Equipment.fromJson(v));
      });
    }
    else {
      equipment = [];
    }
    sections = json['sections'].cast<String>() ?? [];
    shortDescription = json['shortDescription'] ?? "";
    domains = json['domains'].cast<String>() ?? [];
    affiliateBrands = json['affiliateBrands'].cast<String>() ?? [];
    mediaId = json['mediaId'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metaId'] = this.metaId;
    data['label'] = this.label;
    data['isPublic'] = this.isPublic;
    data['isCommunityPublic'] = this.isCommunityPublic;
    data['isConsumerRecipe'] = this.isConsumerRecipe;
    data['isValidated'] = this.isValidated;
    data['isScanToCook'] = this.isScanToCook;
    data['isCookbook'] = this.isCookbook;
    data['isAutoCurated'] = this.isAutoCurated;
    data['appId'] = this.appId;
    data['dateCreated'] = this.dateCreated;
    data['notes'] = this.notes;
    data['tags'] = this.tags;
    data['rating'] = this.rating;
    data['ingredients'] = this.ingredients;
    data['barcodes'] = this.barcodes;
    data['speakableNames'] = this.speakableNames;
    data['course'] = this.course;
    data['mainIngredient'] = this.mainIngredient;
    data['dietaryPreference'] = this.dietaryPreference;
    data['cuisine'] = this.cuisine;
    data['season'] = this.season;
    data['capabilityInstructions'] = this.capabilityInstructions;
    data['styleInstructions'] = this.styleInstructions;
    data['parameterInstructions'] = this.parameterInstructions;
    if (this.menuTreeInstructions != null) {
      data['menuTreeInstructions'] =
          this.menuTreeInstructions!.map((v) => v.toJson()).toList();
    }
    else {
      this.menuTreeInstructions = [MenuTreeInstructions.asEmpty()];
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    else {
      this.media = [];
    }
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    else {
      this.steps = [];
    }
    if (this.ingredientObjects != null) {
      data['ingredientObjects'] =
          this.ingredientObjects!.map((v) => v.toJson()).toList();
    }
    else {
      this.ingredientObjects = [];
    }
    if (this.equipment != null) {
      data['equipment'] = this.equipment!.map((v) => v.toJson()).toList();
    }
    else {
      this.equipment = [];
    }
    data['sections'] = this.sections;
    data['shortDescription'] = this.shortDescription;
    data['domains'] = this.domains;
    data['affiliateBrands'] = this.affiliateBrands;
    data['mediaId'] = this.mediaId;
    return data;
  }

  @override
  String toString() {
    return 'Recipe(id: $id, label: $label, isPublic: $isPublic, isCommunityPublic: $isCommunityPublic, isConsumerRecipe: $isConsumerRecipe, isValidated: $isValidated, isScanToCook: $isScanToCook, isCookbook: $isCookbook, isAutoCurated: $isAutoCurated, appId: $appId, dateCreated: $dateCreated, notes: $notes, tags: $tags, rating: $rating, ingredients: $ingredients, barcodes: $barcodes, speakableNames: $speakableNames, course: $course, mainIngredient: $mainIngredient, dietaryPreference: $dietaryPreference, cuisine: $cuisine, season: $season, capabilityInstructions: $capabilityInstructions, styleInstructions: $styleInstructions, parameterInstructions: $parameterInstructions, menuTreeInstructions: $menuTreeInstructions, media: $media, steps: $steps, ingredientObjects: $ingredientObjects, equipment: $equipment, mediaId: $mediaId)';
  }

  factory Recipe.asEmpty(){
    return Recipe(id: "",
     metaId: "",
    label: "", 
    isPublic: false, 
    isCommunityPublic: false, 
    isConsumerRecipe: false, 
    isValidated: false, 
    isScanToCook: false, 
    isCookbook: false, 
    isAutoCurated: false, 
    appId: "", 
    dateCreated: "", 
    notes: "", 
    tags: [], 
    rating: 0, 
    ingredients: [], 
    barcodes: [], 
    speakableNames: [], 
    course: [], 
    mainIngredient: [], 
    dietaryPreference: [], 
    cuisine: [], 
    season: [], 
    capabilityInstructions: [], 
    styleInstructions: [], 
    parameterInstructions: [], 
    menuTreeInstructions: [MenuTreeInstructions.asEmpty()], 
    media: [Media.asEmpty()], 
    steps: [Steps.asEmpty()], 
    domains: [], 
    affiliateBrands: [],
    equipment: [Equipment.asEmpty()], 
    ingredientObjects: [IngredientObjects.asEmpty()], 
    mediaId: "", 
    sections: [], 
    shortDescription: "");
  }
}

class MenuTreeInstructions {
  String? id;
  String? readyInMins;
  ReadyInMinsRange? readyInMinsRange;
  List<String>? requiredCapabilities;
  List<SelectableOptions>? selectableOptions;
  List<OptionTree>? optionTree;

  MenuTreeInstructions(
      {this.id,
      this.readyInMins,
      this.readyInMinsRange,
      this.requiredCapabilities,
      this.selectableOptions,
      this.optionTree});

  MenuTreeInstructions.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    readyInMins = json['readyInMins'] ?? "";
    readyInMinsRange = json['readyInMinsRange'] != null
        ? new ReadyInMinsRange.fromJson(json['readyInMinsRange'])
        : ReadyInMinsRange.asEmpty();
    requiredCapabilities = json['requiredCapabilities'].cast<String>() ?? "";
    if (json['selectableOptions'] != null) {
      selectableOptions = <SelectableOptions>[];
      json['selectableOptions'].forEach((v) {
        selectableOptions!.add(new SelectableOptions.fromJson(v));
      });
    }
    else {
      selectableOptions = [];
    }
    if (json['optionTree'] != null) {
      optionTree = <OptionTree>[];
      json['optionTree'].forEach((v) {
        optionTree!.add(new OptionTree.fromJson(v));
      });
    }
    else {
      optionTree = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readyInMins'] = this.readyInMins;
    if (this.readyInMinsRange != null) {
      data['readyInMinsRange'] = this.readyInMinsRange!.toJson();
    }
    data['requiredCapabilities'] = this.requiredCapabilities;
    if (this.selectableOptions != null) {
      data['selectableOptions'] =
          this.selectableOptions!.map((v) => v.toJson()).toList();
    }
    if (this.optionTree != null) {
      data['optionTree'] = this.optionTree!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory MenuTreeInstructions.asEmpty(){
    return MenuTreeInstructions(id: "", 
    readyInMins: "", 
    readyInMinsRange: ReadyInMinsRange.asEmpty(), 
    optionTree: [], 
    requiredCapabilities: [], 
    selectableOptions: []);
  }
}

class ReadyInMinsRange {
  String? gte;
  String? lte;

  ReadyInMinsRange({this.gte, this.lte});

  ReadyInMinsRange.fromJson(Map<String, dynamic> json) {
    gte = json['gte'] ?? "";
    lte = json['lte'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gte'] = this.gte;
    data['lte'] = this.lte;
    return data;
  }

  factory ReadyInMinsRange.asEmpty(){
    return ReadyInMinsRange(lte: "", gte: "");
  }
}

class SelectableOptions {
  String? type;
  List<SelectableValues>? selectableValues;

  SelectableOptions({this.type, this.selectableValues});

  SelectableOptions.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? "";
    if (json['selectableValues'] != null) {
      selectableValues = <SelectableValues>[];
      json['selectableValues'].forEach((v) {
        selectableValues!.add(new SelectableValues.fromJson(v));
      });
    }
    else {
      selectableValues = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.selectableValues != null) {
      data['selectableValues'] =
          this.selectableValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory SelectableOptions.asEmpty() {
    return SelectableOptions(type: "", selectableValues: []);
  }
}

class SelectableValues {
  String? type;
  String? description;
  ValueRange? valueRange;
  String? volumeUnit;
  String? consistency;

  SelectableValues(
      {this.type,
      this.description,
      this.valueRange,
      this.volumeUnit,
      this.consistency});

  SelectableValues.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? "";
    description = json['description'] ?? "";
    valueRange = json['valueRange'] != null
        ? new ValueRange.fromJson(json['valueRange'])
        : ValueRange.asEmpty();
    volumeUnit = json['volumeUnit'] ?? "";
    consistency = json['consistency'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['description'] = this.description;
    if (this.valueRange != null) {
      data['valueRange'] = this.valueRange!.toJson();
    }
    data['volumeUnit'] = this.volumeUnit;
    data['consistency'] = this.consistency;
    return data;
  }

  SelectableValues.asEmpty() {
    type = "";
    description = "";
    valueRange = ValueRange.asEmpty();
    volumeUnit = "";
    consistency = "";
  }
}

class ValueRange {
  double? gte;
  double? lte;

  ValueRange({this.gte, this.lte});

  ValueRange.fromJson(Map<String, dynamic> json) {
    gte = json['gte'] ?? 0;
    lte = json['lte'] ?? 0;
  }

  factory ValueRange.asEmpty() {
    return ValueRange(gte: 0, lte: 0);
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gte'] = this.gte;
    data['lte'] = this.lte;
    return data;
  }
}

class OptionTree {
  String? type;
  OptionValue? optionValue;
  List<RecipeOptions>? options;
  Config? config;

  OptionTree({this.type, this.optionValue, this.options, this.config});

  OptionTree.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? "";
    optionValue = json['optionValue'] != null ? new OptionValue.fromJson(json['optionValue']) : OptionValue.asEmpty();
    config = json['config'] != null ? new Config.fromJson(json['config']) : Config.asEmpty();
    if (json['options'] != null) {
      options = <RecipeOptions>[];
      json['options'].forEach((v) {
        options!.add(new RecipeOptions.fromJson(v));
      });
    }
    else {
      options = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.optionValue != null) {
      data['optionValue'] = this.optionValue!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory OptionTree.asEmpty(){
    return OptionTree(type: "", optionValue: OptionValue.asEmpty(), options: [RecipeOptions.asEmpty()]);
  }
}

class OptionValue {
  String? description;
  String? type;
  ValueRange? valueRange;
  String? volumeUnit;
  String? consistency;

  OptionValue({this.type, this.valueRange, this.volumeUnit});

  OptionValue.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? "";
    type = json['type'] ?? "";
    valueRange = json['valueRange'] != null
        ? new ValueRange.fromJson(json['valueRange'])
        : ValueRange.asEmpty();
    volumeUnit = json['volumeUnit'];
    consistency = json['consistency'];
  }

  factory OptionValue.asEmpty() {
    return OptionValue(type: "", valueRange: ValueRange.asEmpty(), volumeUnit: "");
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['type'] = this.type;
    if (this.valueRange != null) {
      data['valueRange'] = this.valueRange!.toJson();
    }
    data['volumeUnit'] = this.volumeUnit;
    data['consistency'] = this.consistency;
    return data;
  }


}

class RecipeOptions {
  OptionValue? optionValue;
  Config? config;

  RecipeOptions({this.optionValue, this.config});

  RecipeOptions.fromJson(Map<String, dynamic> json) {
    optionValue = json['optionValue'] != null
        ? new OptionValue.fromJson(json['optionValue'])
        : OptionValue.asEmpty();
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : Config.asEmpty();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.optionValue != null) {
      data['optionValue'] = this.optionValue!.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    return data;
  }

  factory RecipeOptions.asEmpty(){
    return RecipeOptions(optionValue: OptionValue.asEmpty(), config: Config.asEmpty());
  }
}


class Config {
  String? optionConfigId;
  String? readyInMins;
  ReadyInMinsRange? readyInMinsRange;
  List<String>? requiredCapabilities;
  List<String>? steps;
  List<String>? ingredients;
  List<String>? equipment;

  Config(
      {this.optionConfigId,
      this.readyInMins,
      this.readyInMinsRange,
      this.requiredCapabilities,
      this.steps,
      this.ingredients,
      this.equipment});

  Config.fromJson(Map<String, dynamic> json) {
    optionConfigId = json['optionConfigId'] ?? "";
    readyInMins = json['readyInMins'] ?? "";
    readyInMinsRange = json['readyInMinsRange'] != null
        ? new ReadyInMinsRange.fromJson(json['readyInMinsRange'])
        : ReadyInMinsRange.asEmpty();
    requiredCapabilities = json['requiredCapabilities'].cast<String>() ?? [];
    steps = json['steps'].cast<String>() ?? [];
    ingredients = json['ingredients'].cast<String>() ?? [];
    equipment = json['equipment'].cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionConfigId'] = this.optionConfigId;
    data['readyInMins'] = this.readyInMins;
    if (this.readyInMinsRange != null) {
      data['readyInMinsRange'] = this.readyInMinsRange!.toJson();
    }
    data['requiredCapabilities'] = this.requiredCapabilities;
    data['steps'] = this.steps;
    data['ingredients'] = this.ingredients;
    data['equipment'] = this.equipment;
    return data;
  }
  
  factory Config.asEmpty(){
    return Config(optionConfigId: "", 
    readyInMins: "", 
    readyInMinsRange: ReadyInMinsRange.asEmpty(), 
    requiredCapabilities: [],
    steps: [], 
    ingredients: [], 
    equipment: []);
  }
}

class Media {
  String? id;
  String? type;
  String? mimetype;
  List<Sizes>? sizes;

  Media({this.id, this.type, this.mimetype, this.sizes});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    type = json['type'] ?? "";
    mimetype = json['mimetype'] ?? "";
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
    else {
      sizes = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['mimetype'] = this.mimetype;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory Media.asEmpty(){
    return Media(id: "", type: "", mimetype: "", sizes: [Sizes.asEmpty()]);
  }
}

class Sizes {
  String? id;
  String? widthPixels;
  String? heightPixels;
  String? mediaUrl;
  String? mediaSha256;
  String? internalMediaUrl;

  Sizes(
      {this.id,
      this.widthPixels,
      this.heightPixels,
      this.mediaUrl,
      this.mediaSha256,
      this.internalMediaUrl});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    widthPixels = json['widthPixels'] ?? "";
    heightPixels = json['heightPixels'] ?? "";
    mediaUrl = json['mediaUrl'] ?? "";
    mediaSha256 = json['mediaSha256'] ?? "";
    internalMediaUrl = json['internalMediaUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['widthPixels'] = this.widthPixels;
    data['heightPixels'] = this.heightPixels;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaSha256'] = this.mediaSha256;
    data['internalMediaUrl'] = this.internalMediaUrl;
    return data;
  }

  factory Sizes.asEmpty(){
    return Sizes(id: "", widthPixels: "", heightPixels: "", mediaUrl: "", internalMediaUrl: "", mediaSha256: "");
  }
}

class Steps {
  String? id;
  String? type;
  List<dynamic>? requiredCapabilities;
  String? mode;
  int? mixerTargetWeightGrams;
  String? mediaId;
  String? label;
  int? mixerTargetTimeSeconds;
  int? mixerSpeed;
  int? mixerRelativeViscosityPercentage;
  String? mixerDirection;
  String? directions;
  String? alternateDirection;
  String? tip;
  String? durationMins;

  Steps(
      {this.id,
      this.type,
      this.requiredCapabilities,
      this.mode,
      this.mixerTargetWeightGrams,
      this.mediaId,
      this.label,
      this.mixerTargetTimeSeconds,
      this.mixerSpeed,
      this.mixerRelativeViscosityPercentage,
      this.mixerDirection,
      this.directions,
        this.alternateDirection,
        this.tip,
        this.durationMins
      });

  Steps.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    type = json['type'] ?? "";
    requiredCapabilities = json['requiredCapabilities'] ?? [];
    mode = json['mode'] ?? "";
    mixerTargetWeightGrams = json['mixerTargetWeightGrams'] ?? 0;
    mediaId = json['mediaId'];
    label = json['label'];
    mixerTargetTimeSeconds = json['mixerTargetTimeSeconds'];
    mixerSpeed = json['mixerSpeed'];
    mixerRelativeViscosityPercentage = json['mixerRelativeViscosityPercentage'];
    mixerDirection = json['mixerDirection'];
    directions = json['directions'];
    alternateDirection = json['alternateDirection'];
    tip = json['tip'];
    durationMins = json['durationMins'];
  }

  factory Steps.asEmpty() {
    return Steps(
      id: '',
      type: '',
      requiredCapabilities: [],
      mode: '',
      mixerTargetWeightGrams: 0,
      mediaId: '',
      label: '',
      mixerTargetTimeSeconds: 0,
      mixerSpeed: 0,
      mixerRelativeViscosityPercentage: 0,
      mixerDirection: '',
      directions: '',
      alternateDirection: '',
      tip: '',
      durationMins: ''
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['requiredCapabilities'] = this.requiredCapabilities;
    data['mode'] = this.mode;
    data['mixerTargetWeightGrams'] = this.mixerTargetWeightGrams;
    data['mediaId'] = this.mediaId;
    data['label'] = this.label;
    data['mixerTargetTimeSeconds'] = this.mixerTargetTimeSeconds;
    data['mixerSpeed'] = this.mixerSpeed;
    data['mixerRelativeViscosityPercentage'] =
        this.mixerRelativeViscosityPercentage;
    data['mixerDirection'] = this.mixerDirection;
    data['directions'] = this.directions;
    data['alternateDirection'] = this.alternateDirection;
    data['tip'] = this.tip;
    data['durationMins'] = this.durationMins;
    return data;
  }
}


class IngredientObjects {
  String? id;
  String? name;
  FoodMeasure? foodMeasure;
  String? alternateMeasure;
  String? mediaId;

  IngredientObjects(
      {this.id,
      this.name,
      this.foodMeasure,
      this.alternateMeasure,
      this.mediaId,});

      factory IngredientObjects.asEmpty(){
        return IngredientObjects(
          id: "",
          name: "",
          foodMeasure: FoodMeasure.asEmpty(),
          alternateMeasure: "",
          mediaId: "",
        );
      }

  IngredientObjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    foodMeasure = json['foodMeasure'] != null
        ? new FoodMeasure.fromJson(json['foodMeasure'])
        : FoodMeasure.asEmpty();
    alternateMeasure = json['alternateMeasure'];
    mediaId = json['mediaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.foodMeasure != null) {
      data['foodMeasure'] = this.foodMeasure!.toJson();
    }
    data['alternateMeasure'] = this.alternateMeasure;
    data['mediaId'] = this.mediaId;
    return data;
  }


}

class FoodMeasure {
  String? type;
  ValueRange? valueRange;
  String? weightUnit;
  String? volumeUnit;
  String? unitDescription;
  String? size;

  FoodMeasure({this.type, this.valueRange, this.weightUnit, this.volumeUnit, this.unitDescription, this.size});

  FoodMeasure.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    valueRange = json['valueRange'] != null
        ? new ValueRange.fromJson(json['valueRange'])
        : ValueRange.asEmpty();
    weightUnit = json['weightUnit'];
    volumeUnit = json['volumeUnit'];
    unitDescription = json['unitDescription'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.valueRange != null) {
      data['valueRange'] = this.valueRange!.toJson();
    }
    data['weightUnit'] = this.weightUnit;
    data['volumeUnit'] = this.volumeUnit;
    //data['unitDescription'];
    data['size'] = this.size;
    return data;
  }

  factory FoodMeasure.asEmpty(){
    return FoodMeasure(type: "", valueRange: ValueRange.asEmpty(), weightUnit: "", volumeUnit: "", unitDescription: "");
  }
}

class Equipment {
  String? id;
  String? name;
  String? mediaId;

  Equipment({this.id, this.name, this.mediaId});

  Equipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mediaId = json['mediaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mediaId'] = this.mediaId;
    return data;
  }

  factory Equipment.asEmpty(){
    return Equipment(id: "", name: "", mediaId: "");
  }
}


///## Recipe Helper Class
///This class is used to format the recipe data into a more readable & Accessible format.
///
class RecipeHelper {
  final Recipe recipe;
  RecipeHelper({required this.recipe}){init();}

  late MenuTreeInstructions instructions;
  List<String> servingSizes = [];

  init(){
      //build the variables   
      _getInstructions();
    }

  String get notes {
    return recipe.notes?? "";
  }

  MenuTreeInstructions _getInstructions(){
    recipe.menuTreeInstructions!.forEach((element) {
      if(element.id == "instruction.menu-tree")
        instructions = element;
    });
    return instructions;
  }

  String get readyInMins => instructions.readyInMins.toString();

  List<String> selectableOptionTypes(){
    List<String> types = [];
    instructions.selectableOptions?.forEach((element) {
      types.add(element.type ?? "");
    });
    return types;
  }
  List<List<SelectableValues>> selectableOptionValues(){
    List<List<SelectableValues>> values = [];
    instructions.selectableOptions?.forEach((element) {
      values.add(element.selectableValues ?? []);
    });
    return values;
  }

  List<String> get servingSizesList => servingSizes;

  factory RecipeHelper.asEmpty(){
    return RecipeHelper(recipe: Recipe.asEmpty());
  }
  
}

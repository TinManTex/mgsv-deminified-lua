Scene={
-- シーンに登録されているアクターから指定されたクラスのアクターのテーブルを取得します
--GoogleTranslate: Gets the table of actors of the specified class from the registered actors
  GetActorsByClassName=function(scene,className)
    actors=scene:GetActorList()
    return DataActor.GetActorsByClassName(actors,className)
  end
}

Entity={
--[[FDOC
  @id Entity
  @category FoxCore Entity
  
  エンティティがNULLかどうかを調べます。
  
  {{{
  Entity.IsNull( entity )
  }}}
   entity:: エンティティを指定します。
   戻り値:: エンティティがNULLの場合はtrueを返します。
  
  {{{
  -- サンプル
  if Entity.IsNull( entity ) then
    -- entity は NULL
  end
  }}}
]]
  IsNull=function(entity)
    if entity==nil or entity==NULL then
      return true
    else
      return false
    end
  end,
--[[FDOC
  @id Entity
  @category FoxCore Entity
  
  !!! DEPRECATED !!! - NULL を使って下さい：  
  {{{
  local entity = NULL
  }}}
  
  NULLエンティティをあらわします。
  {{{
  local entity = Entity.Null()
  }}}
]]
  Null=function(entity)
    return NULL
  end
}

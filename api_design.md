# 요구사항
1. 상품 리스트 조회 API
2. 찜 API (찜하기/찜 해제)

## Data
```
Product
- id: int
- level: int
- price: int
- imageUrl: String
- favorite: bool
```

## 상품 리스트 조회 API

GET `/products?categoryType={categoryType}&page={page}&limit={limit}`

### Request
```
@Query

// Enum { coach, goods, background, ... } (코치, 소품, 배경, ...)
* categoryType: String

// 조회 페이지 (팀내 약속에 따라서 0 혹은 1부터 시작)
* page: int

// 한번에 조회할 항목 갯수
* limit: int
```

### Response
```
{
  "success": bool,
  "body": {
    "page": int,
    "limit": int,
    "isLast": bool,
    "list": [
      // Product
      {
        "id": int,
        "level": int,
        "price": int,
        "imageUrl": string,
        "favorite": bool
      }
      ...
    ]
  }
}
```

## 찜하기 API

POST `/products/{productId}/favorite`

### Request
```
@Path

// 상품 Id
* productId: int
```

### Response
```
{
  "success": bool,
  "body": {
    // Product
    "id": int,
    "level": int,
    "price": int,
    "imageUrl": string,
    "favorite": boolean
  }
}
```

## 찜 해제 API

DELETE `/products/{productId}/favorite`

### Request
```
@Path

// 상품 Id
* productId: int
```

### Response
```
{
  "success": bool,
  "body": {
    // Product
    "id": int,
    "level": int,
    "price": int,
    "imageUrl": string,
    "favorite": boolean
  }
}
```

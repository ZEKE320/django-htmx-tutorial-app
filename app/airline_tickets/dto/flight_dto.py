from pydantic import UUID4, BaseModel


class AirportDto(BaseModel):
    id: UUID4
    name: str
    country: str
    prefecture: str
    iata_code: str


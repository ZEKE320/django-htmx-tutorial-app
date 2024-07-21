from pydantic import BaseModel


class AirportDto(BaseModel):
    name: str
    country: str
    prefecture: str
    iata_code: str

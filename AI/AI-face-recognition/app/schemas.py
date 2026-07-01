from pydantic import BaseModel
from typing import List


class Student(BaseModel):
    id: int
    crop_path: str
    bbox: List[int]


class AnalysisResult(BaseModel):
    total_people: int
    known_count: int
    unknown_count: int
    students: List[Student]
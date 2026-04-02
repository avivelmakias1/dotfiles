"""
API Correlation Controller

REST endpoints for querying API correlation results and triggering correlation tasks.
"""

from fastapi import APIRouter

from app.api_correlation.code_correlation.models import CorrelationTriggerRequest, CorrelationTriggerResponse
from app.api_correlation.spec_correlation.models import SpecCorrelationTriggerRequest, SpecCorrelationTriggerResponse

router = APIRouter()


@router.post(
    "/correlate",
    response_model=CorrelationTriggerResponse,
    summary="Trigger correlation",
    description="Trigger correlation task for specific projects or all projects.",
)
async def trigger_correlation(request: CorrelationTriggerRequest):
    """Trigger correlation task."""
    from .tasks import correlate_code_scanning_apis

    project_ids_str = None
    if request.project_ids:
        project_ids_str = [str(pid) for pid in request.project_ids]

    task = correlate_code_scanning_apis.delay(
        project_ids=project_ids_str,
        min_score_threshold=request.min_score_threshold,
    )

    return CorrelationTriggerResponse(
        task_id=task.id,
        status="started",
        message=f"Correlation task started for {'all projects' if not request.project_ids else f'{len(request.project_ids)} projects'}",
    )


@router.post(
    "/spec-correlate",
    response_model=SpecCorrelationTriggerResponse,
    summary="Trigger spec correlation",
    description="Trigger spec-to-traffic correlation using tree-based matching.",
)
async def trigger_spec_correlation(
    request: SpecCorrelationTriggerRequest,
):
    """Trigger spec correlation task."""
    from .tasks import correlate_spec_files

    task = correlate_spec_files.delay(
        spec_file_ids=request.spec_file_ids,
    )

    return SpecCorrelationTriggerResponse(
        task_id=task.id,
        status="started",
        message=f"Spec correlation task started for {'all specs' if not request.spec_file_ids else f'{len(request.spec_file_ids)} specs'}",
    )
